//
//  CheckoutTableViewCell.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 9/7/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class CheckoutTableViewCell: UITableViewCell {

    @IBOutlet weak var imgGoods: UIImageView!
    @IBOutlet weak var lblGoods: UILabel!
    @IBOutlet weak var lblGoodsDetail: UITextView!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblUnitPrice: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
