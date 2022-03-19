//
//  FilterViewController.swift
//  Hands on Core Data
//
//  Created by Bhanuteja on 19/03/22.
//

import UIKit

protocol AddressesFilter: AnyObject {
    func filteredData(_ items: [UserAddressData])
}

class FilterViewController: UIViewController {

    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    weak var addressesFilterDelegate: AddressesFilter?
    private var sortArr = [sortDisplayData]()
    private var sortWithString = "Relavance"
    private var filterWithString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterTableView.register(UINib(nibName: "SortTableCell", bundle: nil), forCellReuseIdentifier: "SortTableCell")
        performSort()
    }

    //Radio
    func performSort() {
        sortArr.removeAll()
        sortBtn.backgroundColor = .white
        filterBtn.backgroundColor = .systemGray5
        sortArr.append(sortDisplayData(dispayString: "Relavance", isDefalt: true, isSortOrFiltr: .sort))
        sortArr.append(sortDisplayData(dispayString: "Pincode", isDefalt: false, isSortOrFiltr: .sort))
        filterTableView.reloadData()
    }

    //Multiple
    func performFilter() {
        sortArr.removeAll()
        filterBtn.backgroundColor = .white
        sortBtn.backgroundColor = .systemGray5
        sortArr.append(sortDisplayData(dispayString: "Nellore", isDefalt: false, isSortOrFiltr: .filter))
        sortArr.append(sortDisplayData(dispayString: "Bang", isDefalt: false, isSortOrFiltr: .filter))
        filterTableView.reloadData()
    }

    @IBAction func closeViewBtnClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func applyBtnClicked(_ sender: Any) {
        var filterNeeded = false
        var sortNeeded = false

        if filterWithString != "" {
            filterNeeded = true
        }
        
        if sortWithString != "Relavance" {
            sortNeeded = true
        }
        
        getFilterData(filterWithString, isFilterSelected: filterNeeded, isSortSelected: sortNeeded)
    }

    @IBAction func resetBtnClicked(_ sender: Any) {
    }
    
    @IBAction func sortBtnClicked(_ sender: Any) {
        performSort()
    }

    @IBAction func filterBtnClicked(_ sender: Any) {
        performFilter()
    }
    
    fileprivate func getFilterData(_ city: String, isFilterSelected: Bool, isSortSelected: Bool) {
        let filteeredData = UserAddressDataModel.shared.getFilterData(city, isFilterSelected: isFilterSelected,
                                                                      isSortSelected: isSortSelected)
        addressesFilterDelegate?.filteredData(filteeredData!)
        dismiss(animated: true)
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortTableCell", for: indexPath) as! SortTableCell
        cell.sortTypeLbl.text = sortArr[indexPath.row].dispayString
        if sortArr[indexPath.row].isDefalt {
            cell.radioImage.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.systemOrange)
            cell.isSelected = true
        } else {
            cell.radioImage.image = UIImage(systemName: "circle")
            cell.isSelected = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SortTableCell
        cell.radioImage.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.systemOrange)
        if sortArr[indexPath.row].isSortOrFiltr == .sort {
            sortWithString = sortArr[indexPath.row].dispayString
        } else {
            filterWithString = sortArr[indexPath.row].dispayString
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SortTableCell
        cell.radioImage.image = UIImage(systemName: "circle")
    }
}
