//
//  SortTableCell.swift
//  Hands on Core Data
//
//  Created by Bhanuteja on 19/03/22.
//

import UIKit

class SortTableCell: UITableViewCell {

    @IBOutlet weak var radioImage: UIImageView!
    @IBOutlet weak var sortTypeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
