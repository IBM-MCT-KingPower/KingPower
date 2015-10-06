//
//  ProductCategoryModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class ProductCategoryModel{
    
    var prc_id          : Int32 = 0
    var prc_prog_id     : Int32 = 0
    var prc_name        : String = ""
    var prc_parent_category_id : Int32 = 0
    var prc_create_date : NSDate = NSDate()
    var prc_update_date : NSDate = NSDate()
    
    var queryGetProductCategoryAll : String = ""
    var queryGetProductCategoryByProductGroupId = ""
    var queryGetProductCategoryById : String = ""
    var queryGetProductCategoryByParentId : String = ""
    
    
    
}