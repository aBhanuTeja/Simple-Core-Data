//
//  ViewController.swift
//  Hands on Core Data
//
//  Created by Bhanuteja on 16/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var filterBtn: UIBarButtonItem!
    @IBOutlet weak var noDataLbl: UILabel!

    private var items: [UserAddressData]?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataTableView.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        dataTableView.estimatedRowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAddressesData()
    }
    
    fileprivate func fetchAddressesData() {
        items?.removeAll()
        if let addresses = UserAddressDataModel.shared.fetchAddresses(), addresses.count > 0 {
            items = addresses
            performOperationForAvailableData()
        } else {
            performOperationForUnAvailableData()
        }
    }

    @IBAction func filterBtnClicked(_ sender: Any) {
        presentFilterView()
//        items?.removeAll()
//        if let addresses = UserAddressDataModel.shared.getFilterData(), addresses.count > 0 {
//            items = addresses
//            performOperationForAvailableData()
//        } else {
//            performOperationForUnAvailableData()
//        }
    }

    fileprivate func presentFilterView() {
        let filterVC = self.storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterViewController
        filterVC.addressesFilterDelegate = self
        if let bottomSheet = filterVC.sheetPresentationController {
            bottomSheet.detents = [.medium(), .large()]
            bottomSheet.prefersGrabberVisible = true
            bottomSheet.prefersScrollingExpandsWhenScrolledToEdge = false
            bottomSheet.preferredCornerRadius = 0
        }
        present(filterVC, animated: true, completion: nil)
    }

    fileprivate func performOperationForAvailableData() {
        dataTableView.isHidden = false
        noDataLbl.isHidden = true
        
        if items!.count > 1 {
            filterBtn.isEnabled = true
            filterBtn.tintColor = .systemOrange
        }
        
        DispatchQueue.main.async {
            self.dataTableView.reloadData()
        }
    }

    fileprivate func performOperationForUnAvailableData() {
        noDataLbl.isHidden = false
        dataTableView.isHidden = true
        filterBtn.isEnabled = false
        filterBtn.tintColor = .clear
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableCell
        cell.setUpData(data: items![indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addressVC = self.storyboard?.instantiateViewController(withIdentifier: "FieldsVC") as! FieldsViewController
        addressVC.selectedItem = items![indexPath.row]
        self.navigationController?.pushViewController(addressVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let itemToBeDeleted = self.items![indexPath.row]
            UserAddressDataModel.shared.deleteUserAddress(data: itemToBeDeleted)
            self.fetchAddressesData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension ViewController: AddressesFilter {
    func filteredData(_ items: [UserAddressData]) {
        self.items?.removeAll()
        self.items = items
        self.dataTableView.reloadData()
    }
}
