//
//  OrderMainController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class OrderMainController{
    
    var database:FMDatabase!
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func insert(ordm_ords_id: Int32, ordm_user_id: Int32, ordm_cust_id: Int32, ordm_no: String, ordm_passport_no: String, ordm_currency: String,ordm_total_price: NSNumber, ordm_flight_departure: Int32, ordm_receupt_departure: String, ordm_picknow_flag: String, ordm_current_location:String, ordm_flight_arrival: Int32, ordm_receipt_arrival: String, ordm_picklater_flag: String, ordm_pickup_location: String, ordm_submit_date: NSDate, ordm_create_date: NSDate, ordm_update_date: NSDate){
        
        var orderMain = OrderMainModel()
        let query = String(format: orderMain.queryInsertOrderMain, ordm_ords_id, ordm_user_id, ordm_cust_id, ordm_no, ordm_passport_no, ordm_currency,ordm_total_price, ordm_flight_departure, ordm_receupt_departure, ordm_picknow_flag, ordm_current_location, ordm_flight_arrival, ordm_receipt_arrival, ordm_picklater_flag, ordm_pickup_location, ordm_submit_date, ordm_create_date, ordm_update_date)
        
        print("\nQUERY: \(query)")
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            print("CREATE ORDER SUCCESSFULLY")
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            
        }
    }
    
    func updateOrderStatusByOrderId(ordm_id: Int32, ordm_ords_id: Int32){
        var orderMain = OrderMainModel()
        let query = String(format: orderMain.queryUpdateOrderStatusById, ordm_ords_id, NSDate(), ordm_id)
        
        print("\nQUERY: \(query)")
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            print("UPDATE ORDER SUCCESSFULLY")
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
    }
    
    func updateReceiptDepartureByOrderId(ordm_id: Int32, ordm_receipt_departure: String){
        var orderMain = OrderMainModel()
        let query = String(format: orderMain.queryUpdateReceiptDepartureById, ordm_receipt_departure, NSDate(), ordm_id )
        
        print("\nQUERY: \(query)")
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            print("UPDATE ORDER SUCCESSFULLY")
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
    }
    
    func updateReceiptArrivalByOrderId(ordm_id: Int32, ordm_receipt_arrival: String){
        var orderMain = OrderMainModel()
        let query = String(format: orderMain.queryUpdateReceiptArrivalById, ordm_receipt_arrival, NSDate(), ordm_id )
        
        print("\nQUERY: \(query)")
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            print("UPDATE ORDER SUCCESSFULLY")
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
    }
    
    
    
    func getOrderByOrderId(ordm_id: Int32) -> OrderMainModel?{
        
        var orderMain = OrderMainModel()
        let query = String(format: orderMain.queryGetOrderMainById, ordm_id, "ORDM_NO", "ORDM_CUST_ID")
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            while rs.next() {
                orderMain.ordm_id = rs.intForColumn("ordm_id")
                orderMain.ordm_ords_id = rs.intForColumn("ordm_ords_id")
                orderMain.ordm_user_id = rs.intForColumn("ordm_user_id")
                orderMain.ordm_cust_id = rs.intForColumn("ordm_cust_id")
                orderMain.ordm_no = rs.stringForColumn("ordm_no")
                orderMain.ordm_currency = rs.stringForColumn("ordm_currency")
                orderMain.ordm_flight_departure = rs.intForColumn("ordm_flight_departure")
                orderMain.ordm_receipt_departure = rs.stringForColumn("ordm_receipt_departure")
                orderMain.ordm_picknow_flag = rs.stringForColumn("ordm_pickup_flag")
                orderMain.ordm_flight_arrival = rs.intForColumn("ordm_flight_arrival")
                orderMain.ordm_receipt_arrival = rs.stringForColumn("ordm_receipt_arrival")
                orderMain.ordm_picklater_flag = rs.stringForColumn("ordm_pickerlater_flag")
                orderMain.ordm_passport_no = rs.stringForColumn("ordm_passport_no")
                orderMain.ordm_current_location = rs.stringForColumn("ordm_current_location")
                orderMain.ordm_pickup_location = rs.stringForColumn("ordm_pickup_location")
                orderMain.ordm_total_price = rs.doubleForColumn("ordm_total_price")
                orderMain.ordm_submit_date = rs.dateForColumn("ordm_submit_date")
                orderMain.ordm_create_date = rs.dateForColumn("ordm_create_date")
                orderMain.ordm_update_date = rs.dateForColumn("ordm_update_date")
                
                return orderMain
                
            }
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
        return nil
        
    }
    
    func getOrderByCustomerId(ordm_cust_id: Int32) -> [OrderMainModel]? { //Need return list of Order
        
        var orderMainArray : [OrderMainModel] = []
        var orderMain = OrderMainModel()
        let query = String(format: orderMain.queryGetOrderMainByCustomerId, ordm_cust_id, "ORDM_NO")
        
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            
            while rs.next(){
                
                orderMain = OrderMainModel()
                orderMain.ordm_id = rs.intForColumn("ordm_id")
                orderMain.ordm_ords_id = rs.intForColumn("ordm_ords_id")
                orderMain.ordm_user_id = rs.intForColumn("ordm_user_id")
                orderMain.ordm_cust_id = rs.intForColumn("ordm_cust_id")
                orderMain.ordm_no = rs.stringForColumn("ordm_no")
                orderMain.ordm_currency = rs.stringForColumn("ordm_currency")
                orderMain.ordm_flight_departure = rs.intForColumn("ordm_flight_departure")
                orderMain.ordm_receipt_departure = rs.stringForColumn("ordm_receipt_departure")
                orderMain.ordm_picknow_flag = rs.stringForColumn("ordm_pickup_flag")
                orderMain.ordm_flight_arrival = rs.intForColumn("ordm_flight_arrival")
                orderMain.ordm_receipt_arrival = rs.stringForColumn("ordm_receipt_arrival")
                orderMain.ordm_picklater_flag = rs.stringForColumn("ordm_pickerlater_flag")
                orderMain.ordm_passport_no = rs.stringForColumn("ordm_passport_no")
                orderMain.ordm_current_location = rs.stringForColumn("ordm_current_location")
                orderMain.ordm_pickup_location = rs.stringForColumn("ordm_pickup_location")
                orderMain.ordm_total_price = rs.doubleForColumn("ordm_total_price")
                orderMain.ordm_submit_date = rs.dateForColumn("ordm_submit_date")
                orderMain.ordm_create_date = rs.dateForColumn("ordm_create_date")
                orderMain.ordm_update_date = rs.dateForColumn("ordm_update_date")
                
                orderMainArray.append(orderMain)
                
                
            }
            return orderMainArray
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
        
        return nil
        
    }
    
}