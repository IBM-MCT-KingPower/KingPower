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
    var prom_effective_date : String = ""
    var prom_expire_date : String = ""
    var prom_expire_flag : String = ""
    var prom_create_date : NSDate = NSDate()
    var prom_update_date : NSDate = NSDate()
    var promotionImageArray : [PromotionImageModel] = []
    
    
    var queryGetPromotionById : String = "SELECT PROM_ID, PROM_TYPE, PROM_NAME, PROM_CONTENT1, PROM_CONTENT2, PROM_EFFECTIVE_DATE, PROM_EXPIRE_DATE, PROM_EXPIRE_FLAG, PROM_CREATE_DATE, PROM_UPDATE_DATE FROM PROMOTION WHERE PROM_ID = %@;"
    
    var queryGetPromotionAllEffective : String = "SELECT PROM_ID, PROM_TYPE, PROM_NAME, PROM_CONTENT1, PROM_CONTENT2, PROM_EFFECTIVE_DATE, PROM_EXPIRE_DATE, PROM_EXPIRE_FLAG, PROM_CREATE_DATE, PROM_UPDATE_DATE FROM PROMOTION WHERE PROM_EXPIRE_FLAG = 'N';"
    
    var queryGetPromotionTypeInfoEffective : String = "SELECT PROM_ID, PROM_TYPE, PROM_NAME, PROM_CONTENT1, PROM_CONTENT2, PROM_EFFECTIVE_DATE, PROM_EXPIRE_DATE, PROM_EXPIRE_FLAG, PROM_CREATE_DATE, PROM_UPDATE_DATE FROM PROMOTION WHERE PROM_EXPIRE_FLAG = 'N' AND PROM_TYPE = 'INFO';"
    
    var queryGetPromotionByTypeAndEffective : String = "SELECT PROM_ID, PROM_TYPE, PROM_NAME, PROM_CONTENT1, PROM_CONTENT2, PROM_EFFECTIVE_DATE, PROM_EXPIRE_DATE, PROM_EXPIRE_FLAG, PROM_CREATE_DATE, PROM_UPDATE_DATE FROM PROMOTION WHERE PROM_TYPE = '%@' AND PROM_EXPIRE_FLAG = 'N';"
    
    
}