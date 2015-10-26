//
//  AddToCartView.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 10/23/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class AddToCartView: UIView {
    @IBOutlet weak var imgProduct:UIImageView!
    @IBOutlet weak var txtProductName:UITextView!
    @IBOutlet weak var lblQuantity : UILabel!
    let gv = GlobalVariable()
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.layer.shadowColor = UIColor.grayColor().CGColor
        self.layer.shadowOffset =  CGSize(width: 5.0, height: 5.0)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.7
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hexString: String(gv.getConfigValue("borderCollectionColor"))).CGColor

    }
    
}
