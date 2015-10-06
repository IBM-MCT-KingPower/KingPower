//
//  CartTableViewCell.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 9/8/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var imgGoods: UIImageView!
    @IBOutlet weak var lblGoods: UILabel!
    @IBOutlet weak var lblGoodsDetail: UITextView!
    @IBOutlet weak var swtPickupType : UISwitch!
    @IBOutlet weak var txtfQuantity : UITextField!
    @IBOutlet weak var stpQuantity : UIStepper!
    @IBOutlet weak var lblTotalPrice : UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var lblUnitPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
