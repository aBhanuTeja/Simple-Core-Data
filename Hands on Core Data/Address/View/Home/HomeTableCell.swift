//
//  HomeTableCell.swift
//  Hands on Core Data
//
//  Created by Bhanuteja on 18/03/22.
//

import UIKit

class HomeTableCell: UITableViewCell {

    @IBOutlet weak var addressImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpData(data: UserAddressData) {
        nameLbl.text = data.fullName!
        addressLbl.text = """
                        \(data.houseNumber!),
                        \(data.locality!),
                        \(data.city!),
                        \(data.state!),
                        Pincode: \(data.pinCode!)
                        
                        Phone number: \(data.phoneNumber!)
                        \(data.ecommerceType!.brandName!)
                        """
    }
}
