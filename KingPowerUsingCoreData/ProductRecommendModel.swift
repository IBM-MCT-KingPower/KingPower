//
//  ProductRecommendModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/9/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class ProductRecommendModel{
    
    var prre_id         : Int32 = 0
    var prre_main_prod_id    : Int32 = 0
    var prre_recom_prod_id    : Int32 = 0
    var prre_create_date : NSDate = NSDate()
    var prre_update_date : NSDate = NSDate()
    var prre_recom_prod : ProductModel = ProductModel()
    
    var queryProductRecommendByMainID : String = "SELECT PRRE_ID, PRRE_MAIN_PROD_ID, PRRE_RECOM_PROD_ID, PRRE_CREATE_DATE, PRRE_UPDATE_DATE FROM PRODUCT_RECOMMEND WHERE PRRE_MAIN_PROD_ID = %d;"
    
}