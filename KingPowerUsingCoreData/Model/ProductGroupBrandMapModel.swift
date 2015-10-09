
//
//  ProductGroupBrandMapModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class ProductGroupBrandMapModel{

    var prbm_id          : Int32 = 0
    var prbm_bran_id     : Int32 = 0
    var prbm_prog_id     : Int32 = 0
    var prbm_create_date : NSDate = NSDate()
    var prbm_update_date : NSDate = NSDate()
    var prbm_bran        : BrandModel = BrandModel()
    var prbm_prog        : ProductGroupModel = ProductGroupModel()
    
    var queryGetMappingByBrandId : String = ""
    var queryGetMappingByProductGroupId : String = ""

}