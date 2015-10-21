//
//  OrderStatusController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class OrderStatusController{
    
    var database:FMDatabase!
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getOrderByStatusId(ords_id: Int32) -> OrderStatusModel? { //Need return OrderStatusObj
        
        var orderStatus = OrderStatusModel()
        let query = String(format: orderStatus.queryGetOrderStatusById, ords_id)
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            while rs.next(){
                orderStatus = OrderStatusModel()
                orderStatus.ords_id = rs.intForColumn("ords_id")
                orderStatus.ords_name = rs.stringForColumn("ords_name")
                
                return orderStatus
            }
            
        }else{
            
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
        return nil
        
    }
    
}