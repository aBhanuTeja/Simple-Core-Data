//
//  FilterViewController.swift
//  Hands on Core Data
//
//  Created by Bhanuteja on 19/03/22.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    
    private var sortArr = [String]()

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
        sortArr.append("Relavance")
        sortArr.append("Pincode")
        filterTableView.reloadData()
    }

    //Multiple
    func performFilter() {
        sortArr.removeAll()
        filterBtn.backgroundColor = .white
        sortBtn.backgroundColor = .systemGray5
        sortArr.append("Nellore")
        sortArr.append("Bangalore")
        filterTableView.reloadData()
    }

    @IBAction func closeViewBtnClicked(_ sender: Any) {
    }
    
    @IBAction func applyBtnClicked(_ sender: Any) {
    }

    @IBAction func resetBtnClicked(_ sender: Any) {
    }
    
    @IBAction func sortBtnClicked(_ sender: Any) {
        performSort()
    }

    @IBAction func filterBtnClicked(_ sender: Any) {
        performFilter()
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortTableCell", for: indexPath) as! SortTableCell
        cell.sortTypeLbl.text = sortArr[indexPath.row]
        return cell
    }
}
