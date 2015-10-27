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
    var orderDetailController = OrderDetailController()
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func insert(ordm_ords_id: Int32, ordm_user_id: Int32, ordm_cust_id: Int32, ordm_passport_no: String, ordm_total_price: Double, ordm_flight_departure: Int32,  ordm_picknow_flag: String,ordm_current_location:String, ordm_flight_arrival: Int32, ordm_picklater_flag: String, ordm_pickup_location: String, ordm_net_total_price:Double, ordm_card_discount:Int32, cartPickNowArray:[CartModel], cartPickLaterArray:[CartModel]) -> OrderMainModel {
        var orderMain = OrderMainModel()
        let cur_running_no = getMaxOrderRunningNo() + 1
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day], fromDate: date)
        let day = String(format: "%02d", components.day)
        let month = String(format: "%02d", components.month)
        let year = String(format: "%02d", components.year)
        let running = String(format: "%05d", cur_running_no)
        
        let orderNo = "KP\(year)\(month)\(day)\(running)"
        let ordm_receipt_departure = ""
        let ordm_receipt_arrival = ""
        let ordm_currency =  "THB"
        let ordm_running_no = cur_running_no

        let query = String(format: orderMain.queryInsertOrderMain, ordm_ords_id, ordm_user_id, ordm_cust_id, orderNo, ordm_passport_no, ordm_currency,ordm_total_price, ordm_flight_departure, ordm_receipt_departure, ordm_picknow_flag, ordm_current_location, ordm_flight_arrival, ordm_receipt_arrival, ordm_picklater_flag, ordm_pickup_location, ordm_running_no, ordm_net_total_price, ordm_card_discount)
        print("\nQUERY: \(query)")
        
        let updateSuccessful = database.executeUpdate(query, withArgumentsInArray: nil)
        if updateSuccessful {
            print("UPDATE ORDERMAIN SUCCESSFULLY")
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            
        }
        
        orderMain = getOrderByMaxRunningNo(orderNo)!
        print("Get max id \(orderMain.ordm_id)")
        let yFlag = GlobalVariable().getConfigValue("flagYes") as! String
        let nFlag = GlobalVariable().getConfigValue("flagNo") as! String
        
        for pickNow in cartPickNowArray {
            print("PICKNOW \(pickNow.cart_id)")
            insertDetail(orderMain.ordm_id, ordd_prod_id: pickNow.cart_prod_id , ordd_quantity: pickNow.cart_quantity, ordd_total_price: Double(pickNow.cart_quantity) * pickNow.cart_prod.prod_price, ordd_pickup_now: yFlag)
        }
        for pickLater in cartPickLaterArray {
            print("PICKLATER \(pickLater.cart_id)")
            insertDetail(orderMain.ordm_id, ordd_prod_id: pickLater.cart_prod_id , ordd_quantity: pickLater.cart_quantity, ordd_total_price: Double(pickLater.cart_quantity) * pickLater.cart_prod.prod_price, ordd_pickup_now: nFlag)
        }
        
        return orderMain
        
    }
    
    func insertDetail(ordd_ordm_id: Int32, ordd_prod_id: Int32, ordd_quantity: Int32, ordd_total_price: Double, ordd_pickup_now: String){
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

    
    func updateOrderStatusByOrderId(ordm_id: Int32, ordm_ords_id: Int32){
        var orderMain = OrderMainModel()
        let query = String(format: orderMain.queryUpdateOrderStatusById, ordm_ords_id, NSDate(), ordm_id)
        
        print("\nQUERY: \(query)")
        let updateSuccessful = database.executeUpdate(query, withArgumentsInArray: nil)
        if updateSuccessful {
            print("INSERT ORDERMAIN SUCCESSFULLY")
            
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
                orderMain.ordm_receipt_departure = rs.stringForColumn("ordm_receipt_departure") == nil ? "": rs.stringForColumn("ordm_receipt_departure")
                orderMain.ordm_picknow_flag = rs.stringForColumn("ordm_picknow_flag")
                orderMain.ordm_flight_arrival = rs.intForColumn("ordm_flight_arrival")
                orderMain.ordm_receipt_arrival = rs.stringForColumn("ordm_receipt_arrival") == nil ? "": rs.stringForColumn("ordm_receipt_arrival")
                orderMain.ordm_picklater_flag = rs.stringForColumn("ordm_picklater_flag")
                orderMain.ordm_passport_no = rs.stringForColumn("ordm_passport_no")
                orderMain.ordm_current_location = rs.stringForColumn("ordm_current_location")
                orderMain.ordm_pickup_location = rs.stringForColumn("ordm_pickup_location")  == nil ? "": rs.stringForColumn("ordm_pickup_location")
                orderMain.ordm_total_price = rs.doubleForColumn("ordm_total_price")
                orderMain.ordm_submit_date = rs.stringForColumn("ordm_submit_date")
                orderMain.ordm_create_date = rs.stringForColumn("ordm_create_date")
                orderMain.ordm_update_date = rs.stringForColumn("ordm_update_date")
                orderMain.ordm_net_total_price = rs.doubleForColumn("ordm_net_total_price")
                orderMain.ordm_running_no = rs.intForColumn("ordm_running_no")
                orderMain.ordm_card_discount = rs.intForColumn("ordm_card_discount")
                orderMain.ordm_ords = orderDetailController.getOrderDetailByOrderId(orderMain.ordm_id)
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
                orderMain.ordm_receipt_departure = rs.stringForColumn("ordm_receipt_departure") == nil ? "": rs.stringForColumn("ordm_receipt_departure")
                orderMain.ordm_picknow_flag = rs.stringForColumn("ordm_picknow_flag")
                orderMain.ordm_flight_arrival = rs.intForColumn("ordm_flight_arrival")
                orderMain.ordm_receipt_arrival = rs.stringForColumn("ordm_receipt_arrival") == nil ? "": rs.stringForColumn("ordm_receipt_arrival")
                orderMain.ordm_picklater_flag = rs.stringForColumn("ordm_picklater_flag")
                orderMain.ordm_passport_no = rs.stringForColumn("ordm_passport_no")
                orderMain.ordm_current_location = rs.stringForColumn("ordm_current_location")
                orderMain.ordm_pickup_location = rs.stringForColumn("ordm_pickup_location")  == nil ? "": rs.stringForColumn("ordm_pickup_location")
                orderMain.ordm_total_price = rs.doubleForColumn("ordm_total_price")
                orderMain.ordm_submit_date = rs.stringForColumn("ordm_submit_date")
                orderMain.ordm_create_date = rs.stringForColumn("ordm_create_date")
                orderMain.ordm_update_date = rs.stringForColumn("ordm_update_date")
                orderMain.ordm_net_total_price = rs.doubleForColumn("ordm_net_total_price")
                orderMain.ordm_running_no = rs.intForColumn("ordm_running_no")
                orderMain.ordm_card_discount = rs.intForColumn("ordm_card_discount")
                orderMain.ordm_ords = orderDetailController.getOrderDetailByOrderId(orderMain.ordm_id)
                orderMainArray.append(orderMain)
                
            }
            return orderMainArray
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
    }
    func getOrderByMaxRunningNo(ordm_no: String) -> OrderMainModel? { //Need return list of Order
        
        var orderMain = OrderMainModel()
        let query = String(format: orderMain.queryGetOrderMainByMaxRunningNo, ordm_no)
        
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
                orderMain.ordm_picknow_flag = rs.stringForColumn("ordm_picknow_flag")
                orderMain.ordm_flight_arrival = rs.intForColumn("ordm_flight_arrival")
                orderMain.ordm_receipt_arrival = rs.stringForColumn("ordm_receipt_arrival")
                orderMain.ordm_picklater_flag = rs.stringForColumn("ordm_picklater_flag")
                orderMain.ordm_passport_no = rs.stringForColumn("ordm_passport_no")
                orderMain.ordm_current_location = rs.stringForColumn("ordm_current_location")
                orderMain.ordm_pickup_location = rs.stringForColumn("ordm_pickup_location")  == nil ? "": rs.stringForColumn("ordm_pickup_location")
                orderMain.ordm_total_price = rs.doubleForColumn("ordm_total_price")
                orderMain.ordm_submit_date = rs.stringForColumn("ordm_submit_date")
                orderMain.ordm_create_date = rs.stringForColumn("ordm_create_date")
                orderMain.ordm_update_date = rs.stringForColumn("ordm_update_date")
                orderMain.ordm_net_total_price = rs.doubleForColumn("ordm_net_total_price")
                orderMain.ordm_running_no = rs.intForColumn("ordm_running_no")
                orderMain.ordm_card_discount = rs.intForColumn("ordm_card_discount")
                break;
                
            }
            return orderMain
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
    }
    func getMaxOrderRunningNo() -> Int32 {
        var orderMainModel = OrderMainModel()
        var maxId : Int32 = 0
        let queryGetMaxId = String(format: orderMainModel.queryGetMaxTodayRunningNo)
        if let rs = database.executeQuery(queryGetMaxId, withArgumentsInArray: nil){
            while rs.next() {
                maxId = rs.intForColumn("max_col")
                break;
            }
        }
        return maxId
    }
    
    func getOrderByCurrentDate(ordm_cust_id: Int32) -> [OrderMainModel]? {
        var orderMainArray : [OrderMainModel] = []
        var orderMain = OrderMainModel()
        
        let query = String(format: orderMain.queryGetOrderMainByCurrentDate, ordm_cust_id, "ORDM_NO")
        
        if let rs = database.executeQuery(query, withArgumentsInArray: nil) {
            while rs.next(){
                
                orderMain = OrderMainModel()
                orderMain.ordm_id = rs.intForColumn("ordm_id")
                orderMain.ordm_ords_id = rs.intForColumn("ordm_ords_id")
                orderMain.ordm_user_id = rs.intForColumn("ordm_user_id")
                orderMain.ordm_cust_id = rs.intForColumn("ordm_cust_id")
                orderMain.ordm_no = rs.stringForColumn("ordm_no")
                orderMain.ordm_currency = rs.stringForColumn("ordm_currency")
                orderMain.ordm_receipt_departure = rs.stringForColumn("ordm_receipt_departure") == nil ? "": rs.stringForColumn("ordm_receipt_departure")
                orderMain.ordm_picknow_flag = rs.stringForColumn("ordm_picknow_flag")
                orderMain.ordm_flight_arrival = rs.intForColumn("ordm_flight_arrival")
                orderMain.ordm_receipt_arrival = rs.stringForColumn("ordm_receipt_arrival") == nil ? "": rs.stringForColumn("ordm_receipt_arrival")
                orderMain.ordm_picklater_flag = rs.stringForColumn("ordm_picklater_flag")
                orderMain.ordm_passport_no = rs.stringForColumn("ordm_passport_no")
                orderMain.ordm_current_location = rs.stringForColumn("ordm_current_location")
                orderMain.ordm_pickup_location = rs.stringForColumn("ordm_pickup_location")  == nil ? "": rs.stringForColumn("ordm_pickup_location")
                orderMain.ordm_total_price = rs.doubleForColumn("ordm_total_price")
                orderMain.ordm_submit_date = rs.stringForColumn("ordm_submit_date")
                orderMain.ordm_create_date = rs.stringForColumn("ordm_create_date")
                orderMain.ordm_update_date = rs.stringForColumn("ordm_update_date")
                orderMain.ordm_net_total_price = rs.doubleForColumn("ordm_net_total_price")
                orderMain.ordm_running_no = rs.intForColumn("ordm_running_no")
                orderMain.ordm_card_discount = rs.intForColumn("ordm_card_discount")
                orderMain.ordm_ords = orderDetailController.getOrderDetailByOrderId(orderMain.ordm_id)
                orderMainArray.append(orderMain)
                
            }
            return orderMainArray
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
    }
    
    func getOrderByHistoryDate(ordm_cust_id: Int32) -> [OrderMainModel]? {
        var orderMainArray : [OrderMainModel] = []
        var orderMain = OrderMainModel()
        
        let query = String(format: orderMain.queryGetOrderMainByHistoryDate, ordm_cust_id, "ORDM_NO")
        
        if let rs = database.executeQuery(query, withArgumentsInArray: nil) {
            while rs.next(){
                
                orderMain = OrderMainModel()
                orderMain.ordm_id = rs.intForColumn("ordm_id")
                orderMain.ordm_ords_id = rs.intForColumn("ordm_ords_id")
                orderMain.ordm_user_id = rs.intForColumn("ordm_user_id")
                orderMain.ordm_cust_id = rs.intForColumn("ordm_cust_id")
                orderMain.ordm_no = rs.stringForColumn("ordm_no")
                orderMain.ordm_currency = rs.stringForColumn("ordm_currency")
                orderMain.ordm_flight_departure = rs.intForColumn("ordm_flight_departure")
                orderMain.ordm_receipt_departure = rs.stringForColumn("ordm_receipt_departure") == nil ? "": rs.stringForColumn("ordm_receipt_departure")
                orderMain.ordm_picknow_flag = rs.stringForColumn("ordm_picknow_flag")
                orderMain.ordm_flight_arrival = rs.intForColumn("ordm_flight_arrival")
                orderMain.ordm_receipt_arrival = rs.stringForColumn("ordm_receipt_arrival") == nil ? "": rs.stringForColumn("ordm_receipt_arrival")
                orderMain.ordm_picklater_flag = rs.stringForColumn("ordm_picklater_flag")
                orderMain.ordm_passport_no = rs.stringForColumn("ordm_passport_no")
                orderMain.ordm_current_location = rs.stringForColumn("ordm_current_location")
                orderMain.ordm_pickup_location = rs.stringForColumn("ordm_pickup_location")  == nil ? "": rs.stringForColumn("ordm_pickup_location")
                orderMain.ordm_total_price = rs.doubleForColumn("ordm_total_price")
                orderMain.ordm_submit_date = rs.stringForColumn("ordm_submit_date")
                orderMain.ordm_create_date = rs.stringForColumn("ordm_create_date")
                orderMain.ordm_update_date = rs.stringForColumn("ordm_update_date")
                orderMain.ordm_net_total_price = rs.doubleForColumn("ordm_net_total_price")
                orderMain.ordm_running_no = rs.intForColumn("ordm_running_no")
                orderMain.ordm_card_discount = rs.intForColumn("ordm_card_discount")
                orderMain.ordm_ords = orderDetailController.getOrderDetailByOrderId(orderMain.ordm_id)
                orderMainArray.append(orderMain)
                
            }
            return orderMainArray
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
        
    }

}