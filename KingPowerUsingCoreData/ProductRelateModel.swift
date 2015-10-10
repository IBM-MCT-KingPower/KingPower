//
//  ProductRelateModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/9/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class ProductRelateModel{
    
    var pror_id         : Int32 = 0
    var pror_main_prod_id    : Int32 = 0
    var pror_relate_prod_id    : Int32 = 0
    var pror_create_date : NSDate = NSDate()
    var pror_update_date : NSDate = NSDate()
    
    var queryProductRelateByMainID : String = "SELECT PROR_ID, PROR_MAIN_PROD_ID, PROR_RELATE_PROD_ID, PROR_CREATE_DATE, PROR_UPDATE_DATE FROM PRODUCT_RELATE WHERE PROR_MAIN_PROD_ID = %@;"
    
}