//
//  CustomerModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class CustomerModel{
    
    var cust_id         : Int = 0
    var cust_first_name : String = ""
    var cust_last_name  : String = ""
    var cust_member_id  : String = ""
    var cust_card_id    : Int = 0
    var cust_card_exp_date : NSDate = NSDate()
    var cust_point      : Int = 0
    var cust_point_exp_date : NSDate = NSDate()
    var cust_create_date : NSDate = NSDate()
    var cust_update_date : NSDate = NSDate()
    
}