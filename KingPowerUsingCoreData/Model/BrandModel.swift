//
//  BrandModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class BrandModel{
    
    var bran_id         : Int32 = 0
    var bran_name       : String = ""
    var bran_create_date : NSDate = NSDate()
    var bran_update_date : NSDate = NSDate()
    
    var queryGetBrandById : String = "SELECT BRAN_ID, BRAN_NAME, BRAN_CREATE_DATE, BRAN_UPDATE_DATE FROM BRAND WHERE BRAN_ID = %@;"
    var queryGetBrandAll  : String = "SELECT BRAN_ID, BRAN_NAME, BRAN_CREATE_DATE, BRAN_UPDATE_DATE FROM BRAND ORDER BY BRAN_NAME;"
    
    var queryGetBrandByProdGroupId : String = "SELECT BRAN_ID, BRAN_NAME, BRAN_CREATE_DATE, BRAN_UPDATE_DATE FROM BRAND  JOIN PRODUCT_GROUP_BRAND_MAP IN PRBM_BRAN_ID = BRAN_ID WHERE PRBM_PROG_ID = %d ORDER BY BRAN_NAME;"
    
}