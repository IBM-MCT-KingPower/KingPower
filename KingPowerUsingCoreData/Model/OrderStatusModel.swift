//
//  OrderStatusModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class OrderStatusModel{
    
    var ords_id         : Int32 = 0
    var ords_name       : String = ""
    var ords_create_date : NSDate = NSDate()
    var ords_update_date : NSDate = NSDate()
    
    var queryGetOrderStatusById : String = ""
    
}