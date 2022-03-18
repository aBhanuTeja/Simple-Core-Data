//
//  ViewController.swift
//  Hands on Core Data
//
//  Created by Bhanuteja on 16/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dataTableView: UITableView!
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
            dataTableView.isHidden = false
            noDataLbl.isHidden = true
            DispatchQueue.main.async {
                self.dataTableView.reloadData()
            }
        } else {
            noDataLbl.isHidden = false
            dataTableView.isHidden = true
        }
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

