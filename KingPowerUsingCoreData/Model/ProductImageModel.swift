//
//  ProductImageModel.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 10/3/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import Foundation

class ProductImageModel {
    
    var proi_id:Int32 = 0
    var proi_prod_id:Int32 = 0
    var proi_prod_image_seq:String = ""
    var proi_image_path:String = ""
    var proi_description:String = ""
    
    var queryProductImageByProductId : String = "SELECT * FROM PRODUCT_IMAGE WHERE PROI_PROD_ID = %@ ORDER BY PROI_PROD_IMAGE_SEQ ASC;"
}