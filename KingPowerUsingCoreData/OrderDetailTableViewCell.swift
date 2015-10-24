//
//  OrderDetailTableViewCell.swift
//  KingPowerUsingCoreData
//
//  Created by Kanoknacha Adisaiparadee on 10/23/15.
//  Copyright © 2015 IBM. All rights reserved.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var imgGoods: UIImageView!
    @IBOutlet weak var lblGoods: UILabel!
    @IBOutlet weak var lblGoodsDetail: UITextView!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblUnitPrice: UILabel!
    @IBOutlet weak var lblUnitCurrency: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblTotalCurrency: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
