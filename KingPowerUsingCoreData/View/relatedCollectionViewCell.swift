//
//  relatedCollectionViewCell.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/27/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

class relatedCollectionViewCell: UICollectionViewCell {
    var productRelate:Products = Products()
    var mainView:ProductDetailViewController = ProductDetailViewController()
    
    @IBOutlet weak var relateButton: UIButton!
    
    var gv = GlobalVariable()
    
    @IBAction func selectImage(sender: AnyObject) {
        mainView.productDetail = productRelate
        mainView.productIdLabel.text = self.productRelate.product_id
        mainView.productNameLabel.text = self.productRelate.product_name
        mainView.productImageLabel.image = UIImage(named: self.productRelate.product_image1)
        
        mainView.productButton1.setImage(UIImage(named: self.productRelate.product_image1), forState: UIControlState.Normal)
        mainView.productButton2.setImage(UIImage(named: self.productRelate.product_image2), forState: UIControlState.Normal)
        mainView.productButton3.setImage(UIImage(named: self.productRelate.product_image3), forState: UIControlState.Normal)
        mainView.productButton4.setImage(UIImage(named: self.productRelate.product_image4), forState: UIControlState.Normal)
        /*
        var currencyFormatter = NSNumberFormatter()
        currencyFormatter.currencyCode = "THB"
        currencyFormatter.numberStyle = .CurrencyStyle
        currencyFormatter.negativeFormat = "-¤#,##0.00"
        mainView.productPrice.text = currencyFormatter.stringFromNumber(self.productRelate.product_price)
*/
        mainView.productPrice.text = NSNumber(double: self.productRelate.product_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
        mainView.productDescript.text = self.productRelate.product_description
        mainView.pickNow.on = self.productRelate.pickup_flag
        mainView.ratingControl.rating = Int(self.productRelate.product_rating)
        mainView.viewDidLoad()
        //mainView.relatedCollection.reloadData()
    }
    
    
}
