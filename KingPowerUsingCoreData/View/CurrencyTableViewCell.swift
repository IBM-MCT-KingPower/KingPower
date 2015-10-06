//
//  CurrencyTableViewCell.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 9/24/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var imgNation: UIImageView!
    @IBOutlet weak var lblNationName: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
