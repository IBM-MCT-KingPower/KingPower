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
    var cart_current_location : String = ""
    var cart_create_date : NSDate = NSDate()
    var cart_update_date : NSDate = NSDate()
    
    var cart_prod       : ProductModel!
    
    var queryInsertCart : String = "INSERT INTO CART (CART_ID, CART_USER_ID, CART_CUST_ID, CART_PROD_ID, CART_QUANTITY, CART_PICKUP_NOW, CART_CURRENT_LOCATION, CART_CREATE_DATE, CART_UPDATE_DATE) VALUES (%d, %d, %d, %d, %d, '%@', %@, %@, %@);"
    var queryUpdatecartById : String = "UPDATE CART SET CART_QUANTITY = %d, CART_PICKUP_NOW = '%@', CART_UPDATE_DATE = %@ WHERE CART_ID = %d;"
    var queryDeleteCartById : String = "DELETE FROM CART WHERE CART_ID = %d;"
    var queryGetCartByCustomerId : String = "SELECT CART_ID, CART_USER_ID, CART_CUST_ID, CART_PROD_ID, CART_QUANTITY, CART_PICKUP_NOW, CART_CURRENT_LOCATION, CART_CREATE_DATE, CART_UPDATE_DATE FROM CART WHERE CART_CUST_ID = %d;"
    
    var queryGetCartPickTypeByCustomerId : String = "SELECT CART_ID, CART_USER_ID, CART_CUST_ID, CART_PROD_ID, CART_QUANTITY, CART_PICKUP_NOW, CART_CURRENT_LOCATION, CART_CREATE_DATE, CART_UPDATE_DATE FROM CART WHERE CART_CUST_ID = %d and CART_PICKUP_NOW = '%@';"
}