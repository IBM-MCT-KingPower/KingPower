//
//  CatagoryTableViewCell.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/11/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class CatagoryTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var clvRelated: UICollectionView!
    @IBOutlet weak var clvRecommended: UICollectionView!
    var index = 0;
    var counter:Int = 1;
    var gv = GlobalVariable()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.clvRelated.delegate = self
        self.clvRecommended.delegate = self
        self.clvRecommended.hidden = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Collection", forIndexPath: indexPath) as! CatagoryCollectionViewCell
        if collectionView == clvRelated {
            
            cell.lblProductName.text = "Fantasy"
            cell.imvProduct.image = UIImage(named: "115758-L1.jpg")
            cell.imvProduct.layer.borderWidth = 1.0
            cell.imvProduct.layer.borderColor = UIColor(hexString: String(gv.getConfigValue("borderCollectionColor"))).CGColor
        }else{
            cell.lblProductName.text = "Age Perfect"
            cell.imvProduct.image = UIImage(named: "030082-L2.jpg")
            cell.imvProduct.layer.borderWidth = 1.0
            cell.imvProduct.layer.borderColor = UIColor(hexString: String(gv.getConfigValue("borderCollectionColor"))).CGColor
        }

        return cell
    }


}
