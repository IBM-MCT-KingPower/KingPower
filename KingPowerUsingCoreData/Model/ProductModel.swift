//
//  ProductModel.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 10/3/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import Foundation

class ProductModel {
    var prod_id:Int32 = 0
    var prod_code:String = ""
    var prod_name:String = ""
    var prod_type:String = ""
    var prod_price:Double = 0
    var prod_description:String = ""
    var prod_details:String = ""
    var prod_remark:String = ""
    var prod_flight_only:String = ""
    var prod_discount:String = ""
    var prod_in_stock:String = ""
    var prod_sale:String = ""
    var prod_weight:Double = 0
    var prod_width:Double = 0
    var prod_height:Double = 0
    var prod_depth:Double = 0
    var prod_color:String = ""
    var prod_gender:String = ""
    var prod_bran_id:Int32 = 0
    var prod_prc_id:Int32 = 0
    var prod_rating:Int32 = 0
    var prod_create_date:NSDate = NSDate()
    var prod_update_date:NSDate = NSDate()
    var prod_imageArray:[ProductImageModel] = []
    var queryProductAll : String = "SELECT * FROM PRODUCT ORDER BY %@ %@;"
}