//
//  PromotionMapModel.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/8/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class PromotionMapModel{

    var prma_id : Int32 = 0
    var prma_prom_id : Int32 = 0
    var prma_bran_id : Int32 = 0
    var prma_prog_id : Int32 = 0
    var prma_prc_id : Int32 = 0
    var prma_prod_id : Int32 = 0
    var prma_create_date : NSDate = NSDate()
    var prma_update_date : NSDate = NSDate()
    
    
    var queryGetPromotionMapByPromotionId : String = "SELECT PRMA_ID, PRMA_PROM_ID, PRMA_BRAN_ID, PRMA_PROG_ID, PRMA_PRC_ID, PRMA_PROD_ID, PRMA_CREATE_DATE, PRMA_UPDATE_DATE FROM PROMOTION_MAP WHERE PRMA_PROM_ID = %d;"
    
}