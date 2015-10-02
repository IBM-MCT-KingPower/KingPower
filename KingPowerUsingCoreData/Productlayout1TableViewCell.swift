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
    @IBOutlet weak var img1Product: UIImageView!
    @IBOutlet weak var img1Tag: UIImageView!
    @IBOutlet weak var img1Plan: UIImageView!
    
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var img2Product: UIImageView!
    @IBOutlet weak var img2Tag: UIImageView!
    @IBOutlet weak var img2Plan: UIImageView!
    
    @IBOutlet weak var v3: UIView!
    @IBOutlet weak var img3Product: UIImageView!
    @IBOutlet weak var img3Tag: UIImageView!
    @IBOutlet weak var img3Plan: UIImageView!
    
    @IBOutlet weak var v4: UIView!
    @IBOutlet weak var img4Product: UIImageView!
    @IBOutlet weak var img4Tag: UIImageView!
    @IBOutlet weak var img4Plan: UIImageView!
    
    @IBOutlet weak var v5: UIView!
    @IBOutlet weak var img5Product: UIImageView!
    @IBOutlet weak var img5Tag: UIImageView!
    @IBOutlet weak var img5Plan: UIImageView!
    
    @IBOutlet weak var v6: UIView!
    @IBOutlet weak var img6Product: UIImageView!
    @IBOutlet weak var img6Tag: UIImageView!
    @IBOutlet weak var img6Plan: UIImageView!
    
    @IBOutlet weak var v7: UIView!
    @IBOutlet weak var img7Product: UIImageView!
    @IBOutlet weak var img7Tag: UIImageView!
    @IBOutlet weak var img7Plan: UIImageView!
    
    @IBOutlet weak var v8: UIView!
    @IBOutlet weak var img8Product: UIImageView!
    @IBOutlet weak var img8Tag: UIImageView!
    @IBOutlet weak var img8Plan: UIImageView!
    
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

}
