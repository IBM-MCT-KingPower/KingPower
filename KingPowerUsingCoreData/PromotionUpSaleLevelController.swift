
//
//  PromotionUpsaleLevelController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/8/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class PromotionUpSaleLevelController{
    var database: FMDatabase!
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getPromotionUpSaleLevelById(){
        
    }
    
    func getPromotionUpSaleLevelByPromotionId(prom_id:Int32) -> [PromotionUpsaleLevelModel]? {
        var promotionUpsaleLevelArray :[PromotionUpsaleLevelModel] = []
        var promotionUpsaleLevel : PromotionUpsaleLevelModel = PromotionUpsaleLevelModel()
        
        let promotionUpsaleLevelQuery :String = String(format: promotionUpsaleLevel.queryGetPromotionUpSaleByPromotionId, prom_id)
        if let rs = database.executeQuery(promotionUpsaleLevelQuery, withArgumentsInArray: nil){
            while rs.next() {
                promotionUpsaleLevel = PromotionUpsaleLevelModel()
                promotionUpsaleLevel.prup_id = rs.intForColumn("prup_id")
                promotionUpsaleLevel.prup_prom_id = rs.intForColumn("prup_prom_id")
                promotionUpsaleLevel.prup_max_amount = rs.doubleForColumn("prup_max_amount")
                print(promotionUpsaleLevel.prup_max_amount )
                promotionUpsaleLevel.prup_max_content = rs.stringForColumn("prup_max_content")
                promotionUpsaleLevel.prup_create_date = rs.dateForColumn("prup_create_date")
                promotionUpsaleLevel.prup_update_date = rs.dateForColumn("prup_update_date")
                promotionUpsaleLevelArray.append(promotionUpsaleLevel)
            }
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return promotionUpsaleLevelArray
    }
    
}