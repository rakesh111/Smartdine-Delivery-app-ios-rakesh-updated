//
//  TblCell.swift
//  Smartdine_Delivery
//
//  Created by Rakesh on 29/12/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import UIKit

class TblCell: UITableViewCell {

    @IBOutlet weak var lblRestaurantName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
