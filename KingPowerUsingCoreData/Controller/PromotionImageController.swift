//
//  PromotionImageController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation


class PromotionImageController{
    
    var database: FMDatabase!
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getPromotionImageById(prmi_id: Int32) -> PromotionImageModel{ //Need return PromotionImageObj
        var promotionImageObj : PromotionImageModel = PromotionImageModel()
        
        let promotionImageQuery :String = String(format: promotionImageObj.queryGetPromotionImageById, prmi_id)
        if let rs = database.executeQuery(promotionImageQuery, withArgumentsInArray: nil){
            while rs.next() {
                promotionImageObj = PromotionImageModel()
                promotionImageObj.prmi_id = rs.intForColumn("prmi_id")
                promotionImageObj.prmi_prom_id = rs.intForColumn("prmi_prom_id")
                promotionImageObj.prmi_img_path = rs.stringForColumn("prmi_img_path")
                promotionImageObj.prmi_img_seq = rs.intForColumn("prmi_img_seq")
                
                break;
            }
            
        }else{
             print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return promotionImageObj
    }
    
    func getPromotionImageByPromotionId(prmi_prom_id: Int32) -> [PromotionImageModel]{ //Need return list of PromotionImageObj
        var promotionImageArray : [PromotionImageModel] = []
        var promotionImageObj : PromotionImageModel = PromotionImageModel()
        
        let promotionImageQuery = String("SELECT PRMI_ID, PRMI_PROM_ID, PRMI_IMG_SEQ, PRMI_IMG_PATH FROM PROMOTION_IMAGE WHERE PRMI_PROM_ID = \(prmi_prom_id) ORDER BY PRMI_IMG_SEQ")
        
//        let promotionImageQuery = String(format: promotionImageObj.queryGetPromotionImageByPromotionId, prmi_prom_id)
        print("QUERY : \(promotionImageQuery)")
        
        if let rs = database.executeQuery(promotionImageQuery, withArgumentsInArray: nil){
            if(rs.hasAnotherRow()){
                print("Not Found PromotionImage for promotionId : \(prmi_prom_id)")
                
            }else{
            
                while rs.next(){
                    promotionImageObj = PromotionImageModel()
                    promotionImageObj.prmi_id = rs.intForColumn("prmi_id")
                    promotionImageObj.prmi_prom_id = rs.intForColumn("prmi_prom_id")
                    promotionImageObj.prmi_img_path = rs.stringForColumn("prmi_img_path")
                    promotionImageObj.prmi_img_seq = rs.intForColumn("prmi_img_seq")
                    promotionImageArray.append(promotionImageObj)
                }
            }
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return promotionImageArray
        
    }
    
    
}