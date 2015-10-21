//
//  OrderDetailController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class OrderDetailController{
    
    var database:FMDatabase!
    var productController = ProductController()
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func insert(ordd_ordm_id: Int32, ordd_prod_id: Int32, ordd_quantity: Int32, ordd_total_price: Double, ordd_pickup_now: String){
        let ordd_redeem_item = "N"
        let orderDetail = OrderDetailModel()
        let query = String(format: orderDetail.queryInsertOrderDetail, ordd_ordm_id, ordd_prod_id, ordd_quantity, ordd_total_price, ordd_redeem_item, ordd_pickup_now)
        let updateSuccessful = database.executeUpdate(query, withArgumentsInArray: nil)
        if updateSuccessful {
            print("INSERT ORDERDETAIL SUCCESSFULLY")
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            
        }
        
        
    }

    func getOrderDetailByOrderId(ordd_ordm_id: Int32) -> [OrderDetailModel]? { //Need return list of OrderDetailObj
        
        var orderDetail = OrderDetailModel()
        var orderDetailArray : [OrderDetailModel] = []
        let query = String(format: orderDetail.queryGetOrderDetailByOrderId, ordd_ordm_id)
        
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            while rs.next(){
                
                orderDetail = OrderDetailModel()
                orderDetail.ordd_id = rs.intForColumn("ordd_id")
                orderDetail.ordd_ordm_id = rs.intForColumn("ordd_ordm_id")
                orderDetail.ordd_quantity = rs.intForColumn("ordd_quantity")
                orderDetail.ordd_total_price = rs.doubleForColumn("ordd_total_price")
                orderDetail.ordd_redeem_item = rs.stringForColumn("ordd_redeem_item")
                orderDetail.ordd_pickup_now = rs.stringForColumn("ordd_pickup_now")
                orderDetail.ordd_create_date = rs.dateForColumn("ordd_create_date")
                orderDetail.ordd_update_date = rs.dateForColumn("ordd_update_date")
                orderDetail.product = productController.getProductByID(orderDetail.ordd_id)
                
                orderDetailArray.append(orderDetail)
                
            }
            return orderDetailArray
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
        
    }


    
}
