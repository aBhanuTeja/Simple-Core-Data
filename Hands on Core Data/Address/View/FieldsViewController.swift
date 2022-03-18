//
//  FieldsViewController.swift
//  Hands on Core Data
//
//  Created by Bhanuteja on 16/03/22.
//

import UIKit

class FieldsViewController: UIViewController {

    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var pinCodeTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var houseNoTF: UITextField!
    @IBOutlet weak var localityTF: UITextField!
    @IBOutlet weak var addressTypeSegment: UISegmentedControl!
    
    var selectedItem: UserAddressData?

    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedItem != nil {
            firstNameTF.text = selectedItem?.fullName
            phoneNumberTF.text = selectedItem?.phoneNumber
            pinCodeTF.text = selectedItem?.pinCode
            stateTF.text = selectedItem?.state
            cityTF.text = selectedItem?.city
            houseNoTF.text = selectedItem?.houseNumber
            localityTF.text = selectedItem?.locality
        }
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        if selectedItem != nil {
            selectedItem?.city = cityTF.text?.firstUppercased
            selectedItem?.fullName = firstNameTF.text?.firstUppercased
            selectedItem?.houseNumber = houseNoTF.text
            selectedItem?.locality = localityTF.text?.firstUppercased
            selectedItem?.phoneNumber = phoneNumberTF.text
            selectedItem?.pinCode = pinCodeTF.text
            selectedItem?.state = stateTF.text?.firstUppercased

            UserAddressDataModel.shared.updateUserAddress(data: selectedItem!)
        } else {
            let context = AddressDatabase.shared.persistentContainer.viewContext
            let saveData = UserAddressData(context: context)
            saveData.city = cityTF.text?.firstUppercased
            saveData.fullName = firstNameTF.text?.firstUppercased
            saveData.houseNumber = houseNoTF.text
            saveData.locality = localityTF.text?.firstUppercased
            saveData.phoneNumber = phoneNumberTF.text
            saveData.pinCode = pinCodeTF.text
            saveData.state = stateTF.text?.firstUppercased

            UserAddressDataModel.shared.saveUserAddress(data: saveData)
        }
        _ = navigationController?.popViewController(animated: true)
    }
}
