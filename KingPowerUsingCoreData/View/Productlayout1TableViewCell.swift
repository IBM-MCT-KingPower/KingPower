//
//  Productlayout1TableViewCell.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/27/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class Productlayout1TableViewCell: UITableViewCell {

    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v1_border: UIView!
    @IBOutlet weak var img1Product: UIImageView!
    @IBOutlet weak var img1Tag: UIImageView!
    @IBOutlet weak var img1Plan: UIImageView!
    @IBOutlet weak var txtv1ProdName:UITextView!
    @IBOutlet weak var lbl1ProdPrice:UILabel!
    
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v2_border: UIView!
    @IBOutlet weak var img2Product: UIImageView!
    @IBOutlet weak var img2Tag: UIImageView!
    @IBOutlet weak var img2Plan: UIImageView!
    @IBOutlet weak var txtv2ProdName:UITextView!
    @IBOutlet weak var lbl2ProdPrice:UILabel!
    
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var v3_border: UIView!
    @IBOutlet weak var img3Product: UIImageView!
    @IBOutlet weak var img3Tag: UIImageView!
    @IBOutlet weak var img3Plan: UIImageView!
    @IBOutlet weak var txtv3ProdName:UITextView!
    @IBOutlet weak var lbl3ProdPrice:UILabel!
    
    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var v4_border: UIView!
    @IBOutlet weak var img4Product: UIImageView!
    @IBOutlet weak var img4Tag: UIImageView!
    @IBOutlet weak var img4Plan: UIImageView!
    @IBOutlet weak var txtv4ProdName:UITextView!
    @IBOutlet weak var lbl4ProdPrice:UILabel!
    
    @IBOutlet weak var v5: UIView!
    @IBOutlet weak var v5_border: UIView!
    @IBOutlet weak var img5Product: UIImageView!
    @IBOutlet weak var img5Tag: UIImageView!
    @IBOutlet weak var img5Plan: UIImageView!
    @IBOutlet weak var txtv5ProdName:UITextView!
    @IBOutlet weak var lbl5ProdPrice:UILabel!
    
    @IBOutlet weak var v6: UIView!
    @IBOutlet weak var v6_border: UIView!
    @IBOutlet weak var img6Product: UIImageView!
    @IBOutlet weak var img6Tag: UIImageView!
    @IBOutlet weak var img6Plan: UIImageView!
    @IBOutlet weak var txtv6ProdName:UITextView!
    @IBOutlet weak var lbl6ProdPrice:UILabel!
    
    @IBOutlet weak var v7: UIView!
    @IBOutlet weak var v7_border: UIView!
    @IBOutlet weak var img7Product: UIImageView!
    @IBOutlet weak var img7Tag: UIImageView!
    @IBOutlet weak var img7Plan: UIImageView!
    @IBOutlet weak var txtv7ProdName:UITextView!
    @IBOutlet weak var lbl7ProdPrice:UILabel!
    
    @IBOutlet weak var v8: UIView!
    @IBOutlet weak var v8_border: UIView!
    @IBOutlet weak var img8Product: UIImageView!
    @IBOutlet weak var img8Tag: UIImageView!
    @IBOutlet weak var img8Plan: UIImageView!
    @IBOutlet weak var txtv8ProdName:UITextView!
    @IBOutlet weak var lbl8ProdPrice:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //let gesture1 = UITapGestureRecognizer(target: self, action: "someAction:")
        //v1.addGestureRecognizer(gesture1)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /*
    func someAction(sender:UITapGestureRecognizer){
        // do other task
        let vc = self.superclass?.storyboardWithName(<#T##name: String##String#>, bundle: <#T##NSBundle?#>)//superclass.storyboard?.instantiateViewControllerWithIdentifier("PromotionDetailStoryboardID") as! PromotionDetailViewController
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    */
    func resetProductView(){
        v1.hidden = true
        img1Product.image =  UIImage()
        img1Tag.image = UIImage()
        img1Plan.image = UIImage()
        txtv1ProdName.text = ""
        lbl1ProdPrice.text = ""
        
        v2.hidden = true
        img2Product.image =  UIImage()
        img2Tag.image = UIImage()
        img2Plan.image = UIImage()
        txtv2ProdName.text = ""
        lbl2ProdPrice.text = ""
        
        v3.hidden = true
        img3Product.image =  UIImage()
        img3Tag.image = UIImage()
        img3Plan.image = UIImage()
        txtv3ProdName.text = ""
        lbl3ProdPrice.text = ""
        
        v4.hidden = true
        img4Product.image =  UIImage()
        img4Tag.image = UIImage()
        img4Plan.image = UIImage()
        txtv4ProdName.text = ""
        lbl4ProdPrice.text = ""
        
        v5.hidden = true
        img5Product.image =  UIImage()
        img5Tag.image = UIImage()
        img5Plan.image = UIImage()
        txtv5ProdName.text = ""
        lbl5ProdPrice.text = ""
        
        v6.hidden = true
        img6Product.image =  UIImage()
        img6Tag.image = UIImage()
        img6Plan.image = UIImage()
        txtv6ProdName.text = ""
        lbl6ProdPrice.text = ""
        
        v7.hidden = true
        img7Product.image =  UIImage()
        img7Tag.image = UIImage()
        img7Plan.image = UIImage()
        txtv7ProdName.text = ""
        lbl7ProdPrice.text = ""
        
        v8.hidden = true
        img8Product.image =  UIImage()
        img8Tag.image = UIImage()
        img8Plan.image = UIImage()
        txtv8ProdName.text = ""
        lbl8ProdPrice.text = ""
    }
}
