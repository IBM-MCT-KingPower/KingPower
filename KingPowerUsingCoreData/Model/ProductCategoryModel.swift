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
    var prc_prog        : ProductGroupModel!// = ProductGroupModel()
    var prc_parent_category : ProductCategoryModel!// = ProductCategoryModel()
    
    var queryGetProductCategoryAll : String = "SELECT PRC_ID, PRC_PROG_ID, PRC_NAME, PRC_PARENT_CATEGORY_ID, PRC_CREATE_DATE, PRC_UPDATE_DATE FROM PRODUCT_CATEGORY ORDER BY PRC_PROG_ID, PRC_NAME;"
    var queryGetProductCategoryByProductGroupId : String = "SELECT PRC_ID, PRC_PROG_ID, PRC_NAME, PRC_PARENT_CATEGORY_ID, PRC_CREATE_DATE, PRC_UPDATE_DATE FROM PRODUCT_CATEGORY WHERE PRC_PROG_ID = %d ORDER BY PRC_PROG_ID, PRC_NAME;"
    var queryGetProductCategoryById : String = "SELECT PRC_ID, PRC_PROG_ID, PRC_NAME, PRC_PARENT_CATEGORY_ID, PRC_CREATE_DATE, PRC_UPDATE_DATE FROM PRODUCT_CATEGORY WHERE PRC_PRC_ID = %d ORDER BY PRC_PROG_ID, PRC_NAME;"
    var queryGetProductCategoryByParentId : String = "SELECT PRC_ID, PRC_PROG_ID, PRC_NAME, PRC_PARENT_CATEGORY_ID, PRC_CREATE_DATE, PRC_UPDATE_DATE FROM PRODUCT_CATEGORY WHERE PRC_PARENT_CATEGORY_ID = %d ORDER BY PRC_PROG_ID, PRC_NAME;"
    
}