//
//  OrderMainModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class OrderMainModel{
    
    var ordm_id         : Int32 = 0
    var ordm_ords_id    : Int32 = 0
    var ordm_user_id    : Int32 = 0
    var ordm_cust_id    : Int32 = 0
    var ordm_no : String = ""
    var ordm_currency   : String = ""
    var ordm_flight_departure : Int32 = 0
    var ordm_receipt_departure : String = ""
    var ordm_picknow_flag : String = ""
    var ordm_flight_arrival : Int32 = 0
    var ordm_receipt_arrival : String = ""
    var ordm_picklater_flag : String = ""
    var ordm_passport_no : String = ""
    var ordm_current_location : String = ""
    var ordm_pickup_location : String = ""
    var ordm_total_price : Double = 0
    var ordm_submit_date : NSDate = NSDate()
    var ordm_create_date : NSDate = NSDate()
    var ordm_update_date : NSDate = NSDate()
    var ordm_running_no  : Int32 = 0
    var ordm_net_total_price : Double = 0
    
    
    var ordm_ords        : [OrderDetailModel]!
    
    var queryInsertOrderMain : String = "INSERT INTO ORDER_MAIN(ORDM_ORDS_ID, ORDM_USER_ID, ORDM_CUST_ID, ORDM_NO, ORDM_PASSPORT_NO, ORDM_CURRENCY, ORDM_TOTAL_PRICE, ORDM_FLIGHT_DEPARTURE, ORDM_RECEIPT_DEPARTURE, ORDM_PICKNOW_FLAG, ORDM_CURRENT_LOCATION, ORDM_FLIGHT_ARRIVAL, ORDM_RECEIPT_ARRIVAL, ORDM_PICKLATER_FLAG, ORDM_PICKUP_LOCATION, ORDM_SUBMIT_DATE, ORDM_CREATE_DATE, ORDM_UPDATE_DATE) VALUES (%@, %@, %@, '%@', '%@', '%@', %@, %@, '%@', '%@', '%@', %@, '%@', '%@', '%@', %@, %@, %@);"
    
    var queryUpdateOrderStatusById : String = "UPDATE ORDER_MAIN SET ORDM_ORDS_ID = %d, ORDM_UPDATE_DATE = %@ WHERE ORDM_ID = %d"
    
    var queryUpdateReceiptDepartureById : String = "UPDATE ORDER_MAIN SET ORDM_RECEIPT_DEPARTURE = '%@', ORDM_UPDATE_DATE = %@ WHERE ORDM_ID = %d"
    
    var queryUpdateReceiptArrivalById : String = "UPDATE ORDER_MAIN SET ORDM_RECEIPT_ARRIVAL = '%@', ORDM_UPDATE_DATE = %@ WHERE ORDM_ID = %d"
    
    var queryGetOrderMainById : String = "SELECT ORDM_ID, ORDM_ORDS_ID, ORDM_USER_ID, ORDM_CUST_ID, ORDM_NO, ORDM_PASSPORT_NO, ORDM_CURRENCY, ORDM_TOTAL_PRICE, ORDM_FLIGHT_DEPARTURE, ORDM_RECEIPT_DEPARTURE, ORDM_PICKNOW_FLAG, ORDM_CURRENT_LOCATION, ORDM_FLIGHT_ARRIVAL, ORDM_RECEIPT_ARRIVAL, ORDM_PICKLATER_FLAG, ORDM_PICKUP_LOCATION, ORDM_SUBMIT_DATE, ORDM_CREATE_DATE, ORDM_UPDATE_DATE FROM ORDER_MAIN WHERE ORDM_ID = %d ORDER BY %@, %@;"
    
    var queryGetOrderMainByCustomerId : String = "SELECT ORDM_ID, ORDM_ORDS_ID, ORDM_USER_ID, ORDM_CUST_ID, ORDM_NO, ORDM_PASSPORT_NO, ORDM_CURRENCY, ORDM_TOTAL_PRICE, ORDM_FLIGHT_DEPARTURE, ORDM_RECEIPT_DEPARTURE, ORDM_PICKNOW_FLAG, ORDM_CURRENT_LOCATION, ORDM_FLIGHT_ARRIVAL, ORDM_RECEIPT_ARRIVAL, ORDM_PICKLATER_FLAG, ORDM_PICKUP_LOCATION, ORDM_SUBMIT_DATE, ORDM_CREATE_DATE, ORDM_UPDATE_DATE FROM ORDER_MAIN WHERE ORDM_CUST_ID = %d ORDER BY %@;"
    
    
}