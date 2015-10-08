//
//  PromotionController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class PromotionController{
    
    var database: FMDatabase!
    var promotionArray: [PromotionModel] = []
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getPromotionById(prom_id: Int32, includeExpire: Bool) -> PromotionModel{ //Need return list of PromotionObj
        
        let promotionObj = PromotionModel()
        let promotionQuery : String
        if(includeExpire){
            promotionQuery = String("SELECT * FROM PROMOTION WHERE PROM_ID = \(prom_id);")
        }else{
            promotionQuery = String("SELECT * FROM PROMOTION WHERE PROM_ID = \(prom_id) AND PROM_EXPIRE_FLAG = 'N';")
        }
        
//        let promotionQuery = String(format: promotionObj.queryGetPromotionById, prom_id)
        
        if let rs = database.executeQuery(promotionQuery, withArgumentsInArray: nil){
            while rs.next(){
                promotionObj.prom_id = rs.intForColumn("prom_id")
                promotionObj.prom_type = rs.stringForColumn("prom_type")
                promotionObj.prom_name = rs.stringForColumn("prom_name")
                promotionObj.prom_content1 = rs.stringForColumn("prom_content1")
                promotionObj.prom_content2 = rs.stringForColumn("prom_content2")
                promotionObj.prom_effective_date = rs.dateForColumn("prom_effective_date")
                promotionObj.prom_expire_date = rs.dateForColumn("prom_expire_date")
                promotionObj.prom_expire_flag = rs.stringForColumn("prom_expire_flag")
                promotionObj.prom_create_date = rs.dateForColumn("prom_create_date")
                promotionObj.prom_update_date = rs.dateForColumn("prom_update_date")
                
                break;
            }
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
        return promotionObj
        
    }
    
    func getPromotionByType(prom_type: String, includeExpire: Bool) -> [PromotionModel]{ //Need return list of PromotionObj
        var promotionArray : [PromotionModel] = []
        var promotionObj : PromotionModel = PromotionModel()
        
        let promotionQuery : String
        if(includeExpire){
            promotionQuery = String("SELECT * FROM PROMOTION WHERE PROM_TYPE = \(prom_type);")
        }else{
            promotionQuery = String("SELECT * FROM PROMOTION WHERE PROM_TYPE = \(prom_type) AND PROM_EXPIRE_FLAG = 'N';")
        }
        
        //promotionQuery = String(format: promotionObj.query....)
        if let rs = database.executeQuery(promotionQuery, withArgumentsInArray: nil){
            while rs.next(){
                promotionObj.prom_id = rs.intForColumn("prom_id")
                promotionObj.prom_type = rs.stringForColumn("prom_type")
                promotionObj.prom_name = rs.stringForColumn("prom_name")
                promotionObj.prom_content1 = rs.stringForColumn("prom_content1")
                promotionObj.prom_content2 = rs.stringForColumn("prom_content2")
                promotionObj.prom_effective_date = rs.dateForColumn("prom_effective_date")
                promotionObj.prom_expire_date = rs.dateForColumn("prom_expire_date")
                promotionObj.prom_expire_flag = rs.stringForColumn("prom_expire_flag")
                promotionObj.prom_create_date = rs.dateForColumn("prom_create_date")
                promotionObj.prom_update_date = rs.dateForColumn("prom_update_date")
                promotionArray.append(promotionObj)
            }
            
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
        return promotionArray
    }
    
    func getAllPromotion(includeExpire: Bool) -> [PromotionModel]{ //Need return list of PromotionObj
        var promotionArray : [PromotionModel] = []
        var promotionObj : PromotionModel = PromotionModel()
        
        let promotionQuery : String
        if(includeExpire){
            promotionQuery = String("SELECT * FROM PROMOTION;")
        }else{
            promotionQuery = String("SELECT * FROM PROMOTION WHERE PROM_EXPIRE_FLAG = 'N';")
        }
        
        if let rs = database.executeQuery(promotionQuery, withArgumentsInArray: nil){
            while rs.next(){
                promotionObj.prom_id = rs.intForColumn("prom_id")
                promotionObj.prom_type = rs.stringForColumn("prom_type")
                promotionObj.prom_name = rs.stringForColumn("prom_name")
                promotionObj.prom_content1 = rs.stringForColumn("prom_content1")
                promotionObj.prom_content2 = rs.stringForColumn("prom_content2")
                promotionObj.prom_effective_date = rs.dateForColumn("prom_effective_date")
                promotionObj.prom_expire_date = rs.dateForColumn("prom_expire_date")
                promotionObj.prom_expire_flag = rs.stringForColumn("prom_expire_flag")
                promotionObj.prom_create_date = rs.dateForColumn("prom_create_date")
                promotionObj.prom_update_date = rs.dateForColumn("prom_update_date")
                promotionArray.append(promotionObj)
            }
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
        return promotionArray
    }
    
}
