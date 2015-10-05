//
//  OrderMainModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class OrderMainModel{
    
    var ordm_id         : Int = 0
    var ordm_ords_id    : Int = 0
    var ordm_user_id    : Int = 0
    var ordm_cust_id    : Int = 0
    var ordm_currency   : String = ""
    var ordm_total_price : NSNumber = NSNumber()
    var ordm_submit_date : NSDate = NSDate()
    var ordm_create_date : NSDate = NSDate()
    var ordm_update_date : NSDate = NSDate()
    
}