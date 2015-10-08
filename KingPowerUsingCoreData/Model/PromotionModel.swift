//
//  PromotionModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class PromotionModel{
    
    var prom_id         : Int32 = 0
    var prom_type       : String = ""
    var prom_name       : String = ""
    var prom_content1   : String = ""
    var prom_content2   : String = ""
    var prom_effective_date : NSDate = NSDate()
    var prom_expire_date : NSDate = NSDate()
    var prom_expire_flag : String = ""
    var prom_create_date : NSDate = NSDate()
    var prom_update_date : NSDate = NSDate()
    var promotionImageArray : [PromotionImageModel] = []
    
    
    var queryGetPromotionById : String = ""
    var queryGetPromotionAllEffective : String = ""
    var queryGetPromotionByType : String = ""
    
}