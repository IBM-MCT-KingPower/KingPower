//
//  OrderListTableViewCell.swift
//  KingPowerUsingCoreData
//
//  Created by Kanoknacha Adisaiparadee on 10/18/15.
//  Copyright © 2015 IBM. All rights reserved.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var mOrderNo: UILabel!
    @IBOutlet weak var mOrderAmt: UILabel!
    @IBOutlet weak var mOrderTotal: UILabel!
    @IBOutlet weak var mOrderDateTime: UILabel!
    @IBOutlet weak var mOrderStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
