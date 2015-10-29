//
//  CatagoryTableViewCell.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/11/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

protocol collectionDelegate {
    func setSelected(isRelated : Bool, index : Int)
}

class CatagoryTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    var delegate:collectionDelegate?
    @IBOutlet weak var clvRelated: UICollectionView!
    @IBOutlet weak var clvRecommended: UICollectionView!
    var prodRelated:[ProductModel] = []
    var prodRecommend:[ProductModel] = []
    var index = 0;
    var counter:Int = 1;
    var gv = GlobalVariable()
    var vc = ProductDetailViewController()
    
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
        if collectionView == clvRelated {
            return self.prodRelated.count
        }else{
            return self.prodRecommend.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Collection", forIndexPath: indexPath) as! CatagoryCollectionViewCell
        let row = indexPath.row
        if collectionView == clvRelated {
            cell.lblProductName.text = self.prodRelated[row].prod_name
            cell.lblProductPrice.text = NSDecimalNumber(double: self.prodRelated[row].prod_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
            cell.imvProduct.image = UIImage(named: self.prodRelated[row].prod_imageArray[0].proi_image_path)
            cell.imvProduct.layer.borderWidth = 1.0
            cell.imvProduct.layer.borderColor = UIColor(hexString: String(gv.getConfigValue("borderCollectionColor"))).CGColor
            if self.prodRelated[row].prod_arrival_flag == "Y" {
                cell.imgHotItem.hidden = false
            }else {
                cell.imgHotItem.hidden = true
            }
            if self.prodRelated[row].prod_flight_only == "Y" {
                cell.imgFlightOnly.hidden = false
            }else{
                cell.imgFlightOnly.hidden = true
            }
            
        }else{
            cell.lblProductName.text = self.prodRecommend[row].prod_name
            cell.lblProductPrice.text = NSDecimalNumber(double: self.prodRecommend[row].prod_price).currency + " " + String(gv.getConfigValue("defaultCurrency"))
            cell.imvProduct.image = UIImage(named: self.prodRecommend[row].prod_imageArray[0].proi_image_path)
            cell.imvProduct.layer.borderWidth = 1.0
            cell.imvProduct.layer.borderColor = UIColor(hexString: String(gv.getConfigValue("borderCollectionColor"))).CGColor
            if self.prodRecommend[row].prod_arrival_flag == "Y" {
                cell.imgHotItem.hidden = false
            }else {
                cell.imgHotItem.hidden = true
            }
            if self.prodRecommend[row].prod_flight_only == "Y" {
                cell.imgFlightOnly.hidden = false
            }else{
                cell.imgFlightOnly.hidden = true
            }
        }

        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == clvRelated {
            delegate!.setSelected(true, index: indexPath.row)
        }else{
            delegate!.setSelected(false, index: indexPath.row)
        }
    }


}
