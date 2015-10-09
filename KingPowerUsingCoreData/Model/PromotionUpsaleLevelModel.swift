//
//  PromotionDetailModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class PromotionUpsaleLevelModel{
    
    var prup_id : Int32 = 0
    var prup_prom_id : Int32 = 0
    var prup_max_amount : NSNumber = NSNumber()
    var prup_max_content : String = ""
    var prup_create_date : NSDate = NSDate()
    var prup_update_date : NSDate = NSDate()
    
    
    var queryGetPromotionUpSaleByPromotionId: String = "SELECT PRUP_ID, PRUP_PROM_ID, PRUP_MAX_AMOUNT, PRUP_MAX_CONTENT, PRUP_CREATE_DATE, PRUP_UPDATE_DATE FROM PROMOTION_UPSALE_LEVEL WHERE PRUP_PROM_ID = %@;"
    var queryGetPromotionUpSaleById : String = "SELECT PRUP_ID, PRUP_PROM_ID, PRUP_MAX_AMOUNT, PRUP_MAX_CONTENT, PRUP_CREATE_DATE, PRUP_UPDATE_DATE FROM PROMOTION_UPSALE_LEVEL WHERE PRUP_ID = %@;"
    
}