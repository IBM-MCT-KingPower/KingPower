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
    
    func getPromotionById(){ //Need return list of PromotionObj
        var promotionObj = PromotionModel()
//        let promotionQuery = String(format: promotionObj.)
        
        
        
//        var prodbyOrderlist = ProductModel()
//        let prodQuery = String(format: prodbyOrderlist.queryProductAll, fieldname, sort)
//        print(prodQuery)
//        if let rs = database.executeQuery(prodQuery, withArgumentsInArray: nil) {
//            
//            while rs.next(){
//                prodbyOrderlist = ProductModel()
//                prodbyOrderlist.prod_id = rs.intForColumn("prod_id")
//                prodbyOrderlist.prod_code = rs.stringForColumn("prod_code")
//                prodbyOrderlist.prod_name = rs.stringForColumn("prod_name")
        
        
    }
    
    func getPromotionByType(){ //Need return list of PromotionObj
        
    }
    
    func getAllPromotion(){ //Need return list of PromotionObj
        
    }
    
}
