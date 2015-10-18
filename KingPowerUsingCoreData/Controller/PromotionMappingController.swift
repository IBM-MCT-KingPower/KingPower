//
//  PromotionDetailController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class PromotionMappingContoller {
    
    var database: FMDatabase!
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    
    func getPromotionMappingByPromotionId(prom_id: Int) -> PromotionMapModel? {
        var promotionMap = PromotionMapModel()
        let query = String(format: promotionMap.queryGetPromotionMapByPromotionId, prom_id)
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            while rs.next(){
                promotionMap.prma_id = rs.intForColumn("prma_id")
                promotionMap.prma_prom_id = rs.intForColumn("prma_prom_id")
                promotionMap.prma_prc_id = rs.intForColumn("prma_prc_id")
                promotionMap.prma_prog_id = rs.intForColumn("prma_prog_id")
                promotionMap.prma_bran_id = rs.intForColumn("prma_bran_id")
                promotionMap.prma_prod_id = rs.intForColumn("prma_prod_id")
    
                return promotionMap
            }
    
        }else{
                print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return nil
    
    }
    
}  
