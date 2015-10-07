//
//  ProductController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 10/6/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import Foundation

class ProductController {
    
    var database:FMDatabase!
    var productArray:[ProductModel] = []
    
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getProductByID(){
        
    }
    
    func getProductByOrder(fieldname: String,sort: String)->[ProductModel]{
        var prodbyOrderlist = ProductModel()
        let prodQuery = String(format: prodbyOrderlist.queryProductAll, fieldname, sort)
        print(prodQuery)
        if let rs = database.executeQuery(prodQuery, withArgumentsInArray: nil) {
            
            while rs.next(){
                prodbyOrderlist = ProductModel()
                prodbyOrderlist.prod_id = rs.intForColumn("prod_id")
                prodbyOrderlist.prod_code = rs.stringForColumn("prod_code")
                prodbyOrderlist.prod_name = rs.stringForColumn("prod_name")
                prodbyOrderlist.prod_type = rs.stringForColumn("prod_type")
                prodbyOrderlist.prod_price = rs.doubleForColumn("prod_price")
                prodbyOrderlist.prod_discount_price = rs.doubleForColumn("prod_discount_price")
                prodbyOrderlist.prod_description = rs.stringForColumn("prod_description")
                prodbyOrderlist.prod_details = rs.stringForColumn("prod_details")
                prodbyOrderlist.prod_remark = rs.stringForColumn("prod_remark")
                prodbyOrderlist.prod_flight_only = rs.stringForColumn("prod_flight_only")
                prodbyOrderlist.prod_in_stock = rs.stringForColumn("prod_in_stock")
                prodbyOrderlist.prod_sale = rs.stringForColumn("prod_sale")
                prodbyOrderlist.prod_weight = rs.doubleForColumn("prod_weight")
                prodbyOrderlist.prod_width = rs.doubleForColumn("prod_width")
                prodbyOrderlist.prod_height = rs.doubleForColumn("prod_height")
                prodbyOrderlist.prod_depth = rs.doubleForColumn("prod_depth")
                prodbyOrderlist.prod_color = String(rs.stringForColumn("prod_color"))
                prodbyOrderlist.prod_gender = rs.stringForColumn("prod_gender")
                prodbyOrderlist.prod_bran_id = rs.intForColumn("prod_bran_id")
                prodbyOrderlist.prod_prc_id = rs.intForColumn("prod_prc_id")
                prodbyOrderlist.prod_rating = rs.intForColumn("prod_rating")
                prodbyOrderlist.prod_create_date = rs.dateForColumn("prod_create_date")
                prodbyOrderlist.prod_update_date = rs.dateForColumn("prod_update_date")
                prodbyOrderlist.prod_imageArray = getProductImage(prodbyOrderlist.prod_id )
                self.productArray.append(prodbyOrderlist)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return self.productArray
    }
    
    func getProductImage(prod_id: Int32)->[ProductImageModel]{
        var image:[ProductImageModel] = []
        var prodImagelist = ProductImageModel()
        let proiQuery = String(format: prodImagelist.queryProductImageByProductId, String(prod_id))
        if let rs = database.executeQuery(proiQuery, withArgumentsInArray: nil) {
            
            while rs.next(){
                prodImagelist = ProductImageModel()
                prodImagelist.proi_id = rs.intForColumn("proi_id")
                prodImagelist.proi_prod_id = rs.intForColumn("proi_id")
                prodImagelist.proi_prod_image_seq = rs.stringForColumn("proi_prod_image_seq")
                prodImagelist.proi_image_path = rs.stringForColumn("proi_image_path")
                image.append(prodImagelist)
            }
            if (image.count==0){
                let prodImagelist = ProductImageModel()
                prodImagelist.proi_id = 0
                prodImagelist.proi_prod_id = prod_id
                prodImagelist.proi_prod_image_seq = ""
                prodImagelist.proi_image_path = "noimage"
                image.append(prodImagelist)
            }
            
        }
        return image
    }
    
}