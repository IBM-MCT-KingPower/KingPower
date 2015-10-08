//
//  ProductImageController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class ProductImageController{
    var database:FMDatabase!
    
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getProductImageById(proi_id:Int32) -> ProductImageModel { //Need return productImageObj
        var prodImage = ProductImageModel()
        let proiQuery = String(format: prodImage.queryProductImageByProductId, String(proi_id))
        if let rs = database.executeQuery(proiQuery, withArgumentsInArray: nil) {
            
            while rs.next(){
                prodImage = ProductImageModel()
                prodImage.proi_id = rs.intForColumn("proi_id")
                prodImage.proi_prod_id = rs.intForColumn("proi_id")
                prodImage.proi_prod_image_seq = rs.stringForColumn("proi_prod_image_seq")
                prodImage.proi_image_path = rs.stringForColumn("proi_image_path")
                break;
            }
        }
        return prodImage
    }
    
    func getProductImageByProductId(prod_id:Int32) -> [ProductImageModel] { //Need return list of productImageObj
        var imageArray:[ProductImageModel] = []
        var prodImage = ProductImageModel()
        let proiQuery = String(format: prodImage.queryProductImageByProductId, String(prod_id))
        if let rs = database.executeQuery(proiQuery, withArgumentsInArray: nil) {
            while rs.next(){
                prodImage = ProductImageModel()
                prodImage.proi_id = rs.intForColumn("proi_id")
                prodImage.proi_prod_id = rs.intForColumn("proi_id")
                prodImage.proi_prod_image_seq = rs.stringForColumn("proi_prod_image_seq")
                prodImage.proi_image_path = rs.stringForColumn("proi_image_path")
                imageArray.append(prodImage)
            }
            if (imageArray.count==0){
                prodImage = ProductImageModel()
                prodImage.proi_id = 0
                prodImage.proi_prod_id = prod_id
                prodImage.proi_prod_image_seq = ""
                prodImage.proi_image_path = "noimage"
                imageArray.append(prodImage)
            }
            
        }
        return imageArray
    }
    
}
