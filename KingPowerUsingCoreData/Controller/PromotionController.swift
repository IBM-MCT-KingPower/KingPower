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
    var promotionImageController = PromotionImageController()
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getPromotionById(prom_id: Int32) -> PromotionModel{ //Need return list of PromotionObj
        
        var promotionObj = PromotionModel()
        let promotionQuery : String = String(format: promotionObj.queryGetPromotionById, prom_id)

        if let rs = database.executeQuery(promotionQuery, withArgumentsInArray: nil){
            while rs.next(){
                promotionObj = PromotionModel()
                promotionObj.prom_id = rs.intForColumn("prom_id")
                promotionObj.prom_type = rs.stringForColumn("prom_type")
                promotionObj.prom_name = rs.stringForColumn("prom_name")
                promotionObj.prom_content1 = rs.stringForColumn("prom_content1")
                promotionObj.prom_content2 = rs.stringForColumn("prom_content2") == nil ? "":rs.stringForColumn("prom_content2")
                promotionObj.prom_effective_date = rs.stringForColumn("prom_effective_date")
                promotionObj.prom_expire_date = rs.stringForColumn("prom_expire_date")
                promotionObj.prom_expire_flag = rs.stringForColumn("prom_expire_flag")
                promotionObj.prom_create_date = rs.dateForColumn("prom_create_date")
                promotionObj.prom_update_date = rs.dateForColumn("prom_update_date")
                promotionObj.promotionImageArray = promotionImageController.getPromotionImageByPromotionId(promotionObj.prom_id)
                
                break;
            }
            
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
        return promotionObj
        
    }
    
    func getPromotionByTypeAndEffective(prom_type: String, includeExpire: Bool) -> [PromotionModel]{ //Need return list of PromotionObj
        var promotionArray : [PromotionModel] = []
        var promotionObj : PromotionModel = PromotionModel()
        
        let promotionQuery : String = String(format: promotionObj.queryGetPromotionByTypeAndEffective, prom_type)

        if let rs = database.executeQuery(promotionQuery, withArgumentsInArray: nil){
            while rs.next(){
                promotionObj = PromotionModel()
                promotionObj.prom_id = rs.intForColumn("prom_id")
                promotionObj.prom_type = rs.stringForColumn("prom_type")
                promotionObj.prom_name = rs.stringForColumn("prom_name")
                promotionObj.prom_content1 = rs.stringForColumn("prom_content1")
                promotionObj.prom_content2 = rs.stringForColumn("prom_content2") == nil ? "":rs.stringForColumn("prom_content2")
                promotionObj.prom_effective_date = rs.stringForColumn("prom_effective_date")
                promotionObj.prom_expire_date = rs.stringForColumn("prom_expire_date")
                promotionObj.prom_expire_flag = rs.stringForColumn("prom_expire_flag")
                promotionObj.prom_create_date = rs.dateForColumn("prom_create_date")
                promotionObj.prom_update_date = rs.dateForColumn("prom_update_date")
                promotionObj.promotionImageArray = promotionImageController.getPromotionImageByPromotionId(promotionObj.prom_id)
                
                promotionArray.append(promotionObj)
            }
            
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
        return promotionArray
    }
    
    func getPromotionAllEffective() -> [PromotionModel]{ //Need return list of PromotionObj
        var promotionArray : [PromotionModel] = []
        var promotionObj : PromotionModel = PromotionModel()
        
        let promotionQuery : String = String(format: promotionObj.queryGetPromotionAllEffective)
        
        if let rs = database.executeQuery(promotionQuery, withArgumentsInArray: nil){
            while rs.next(){
                promotionObj = PromotionModel()
                promotionObj.prom_id = rs.intForColumn("prom_id")
                promotionObj.prom_type = rs.stringForColumn("prom_type")
                promotionObj.prom_name = rs.stringForColumn("prom_name")
                promotionObj.prom_content1 = rs.stringForColumn("prom_content1")
                promotionObj.prom_content2 = rs.stringForColumn("prom_content2") == nil ? "":rs.stringForColumn("prom_content2")
                promotionObj.prom_effective_date = rs.stringForColumn("prom_effective_date")
                promotionObj.prom_expire_date = rs.stringForColumn("prom_expire_date")
                promotionObj.prom_expire_flag = rs.stringForColumn("prom_expire_flag")
                promotionObj.prom_create_date = rs.dateForColumn("prom_create_date")
                promotionObj.prom_update_date = rs.dateForColumn("prom_update_date")
                promotionObj.promotionImageArray = promotionImageController.getPromotionImageByPromotionId(promotionObj.prom_id)
                print("PROMOTION ID: \(promotionObj.prom_id) FOUND \(promotionObj.promotionImageArray.count) IMAGES")
                
                promotionArray.append(promotionObj)
            }
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
        return promotionArray
    }
    
    
    func getPromotionTypeInfoEffective() -> [PromotionModel]{ //Need return list of PromotionObj
        var promotionArray : [PromotionModel] = []
        var promotionObj : PromotionModel = PromotionModel()
        
        let promotionQuery : String = String(format: promotionObj.queryGetPromotionTypeInfoEffective)
        
        if let rs = database.executeQuery(promotionQuery, withArgumentsInArray: nil){
            while rs.next(){
                promotionObj = PromotionModel()
                promotionObj.prom_id = rs.intForColumn("prom_id")
                promotionObj.prom_type = rs.stringForColumn("prom_type")
                promotionObj.prom_name = rs.stringForColumn("prom_name")
                promotionObj.prom_content1 = rs.stringForColumn("prom_content1")
                promotionObj.prom_content2 = rs.stringForColumn("prom_content2") == nil ? "":rs.stringForColumn("prom_content2")
                promotionObj.prom_effective_date = rs.stringForColumn("prom_effective_date")
                promotionObj.prom_expire_date = rs.stringForColumn("prom_expire_date")
                promotionObj.prom_expire_flag = rs.stringForColumn("prom_expire_flag")
                promotionObj.prom_create_date = rs.dateForColumn("prom_create_date")
                promotionObj.prom_update_date = rs.dateForColumn("prom_update_date")
                promotionObj.promotionImageArray = promotionImageController.getPromotionImageByPromotionId(promotionObj.prom_id)
                print("PROMOTION ID: \(promotionObj.prom_id) FOUND \(promotionObj.promotionImageArray.count) IMAGES")
                
                promotionArray.append(promotionObj)
            }
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
        return promotionArray
    }
}
