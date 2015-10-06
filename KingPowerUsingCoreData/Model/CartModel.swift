//
//  CartModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class CartModel{
    
    var cart_id         : Int32 = 0
    var cart_user_id    : Int32 = 0
    var cart_cust_id    : Int32 = 0
    var cart_prod_id    : Int32 = 0
    var cart_quantity   : Int32 = 0
    var cart_pickup_now  : String = ""
    var cart_create_date : NSDate = NSDate()
    var cart_update_date : NSDate = NSDate()
    
    var queryInsertCart : String = ""
    var queryUpdatecartById : String = ""
    var queryDeleteCartById : String = ""
    var queryGetCartByCustomerId : String = ""
    
    
}