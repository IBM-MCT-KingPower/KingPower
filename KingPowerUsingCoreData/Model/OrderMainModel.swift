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
    var ordm_currency   : String = ""
    var ordm_flight_departure : Int32 = 0
    var ordm_receipt_departure : String = ""
    var ordm_picknow_flag : String = ""
    var ordm_flight_arrival : Int32 = 0
    var ordm_receipt_arrival : String = ""
    var ordm_picklater_flag : String = ""
    var ordm_no : String = ""
    var ordm_passport_no : String = ""
    var ordm_current_location : String = ""
    var ordm_pickup_location : String = ""
    var ordm_total_price : NSNumber = NSNumber()
    var ordm_submit_date : NSDate = NSDate()
    var ordm_create_date : NSDate = NSDate()
    var ordm_update_date : NSDate = NSDate()
    
    var queryInsertOrderMain : String = ""
    var queryUpdateOrderMainById : String = ""
    var queryGetOrderMainById : String = ""
    var queryGetOrderMainByCustomerId : String = ""
    
    
}