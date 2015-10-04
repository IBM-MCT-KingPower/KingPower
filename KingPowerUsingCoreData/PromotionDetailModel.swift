//
//  PromotionDetailModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class PromotionDetailModel{
    
    var prmd_id         : Int = 0
    var prmd_prom_id    : Int = 0
    var prmd_seq        : Int = 0
    var prmd_price      : NSNumber = NSNumber()
    var prmd_discount   : NSNumber = NSNumber()
    var prmd_discount_unit : String = ""
    var prmd_quantity   : Int = 0
    var prmd_prod_id    : Int = 0
    var prmd_start_date : NSDate = NSDate()
    var prmd_expiry_date : NSDate = NSDate()
    
}