//
//  OrderDetailModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class OrderDetailModel{
    
    var ordd_id         : Int = 0
    var ordd_ordm_id    : Int = 0
    var ordd_seq        : Int = 0
    var ordd_prod_id    : Int = 0
    var ordd_quantity   : Int = 0
    var ordd_total_price    : NSNumber = NSNumber()
    var ordd_redeem_item    : String = ""
    var ordd_pickup_now : String = ""
    var ordd_create_date : NSDate = NSDate()
    var ordd_update_date : NSDate = NSDate()
    
}