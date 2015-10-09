//
//  ProductGroupModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class ProductGroupModel{
    
    var prog_id         : Int32 = 0
    var prog_name       : String = ""
    var prog_create_date : NSDate = NSDate()
    var prog_update_date : NSDate = NSDate()
    
    var queryGetProductGroupById : String = "SELECT PROG_ID, PROG_NAME, PROG_CREATE_DATE, PROG_UPDATE_DATE FROM PRODUCT_GROUP WHERE PROG_ID = %@ ORDER BY PROG_NAME;"
    var queryGetProductGroupAll : String = "SELECT PROG_ID, PROG_NAME, PROG_CREATE_DATE, PROG_UPDATE_DATE FROM PRODUCT_GROUP ORDER BY PROG_NAME;"
    
}