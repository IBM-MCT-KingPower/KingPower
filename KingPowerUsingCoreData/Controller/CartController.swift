//
//  CartController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class CartController{
    
    var database:FMDatabase!
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func insert(cart_user_id: Int32, cart_cust_id: Int32, cart_prod_id: Int32, cart_quantity: Int32, cart_pickup_now: String, cart_current_location: String, cart_create_date: NSDate, cart_update_date: NSDate){
        
        var cartModel = CartModel()
        let query = String(format: cartModel.queryInsertCart, cart_user_id, cart_cust_id, cart_prod_id, cart_quantity, cart_pickup_now, cart_current_location, cart_create_date, cart_update_date)
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            print("INSERT CART SUCCESSFULLY")
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        
        }
    }
    
    func updateById(cart_id: Int32, cart_quantity: Int32, cart_pickup_now: String, cart_update_date: NSDate){ //Need
        var cartModel = CartModel()
        let query = String(format: cartModel.queryUpdatecartById, cart_quantity, cart_pickup_now, cart_update_date, cart_id)
        
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            print("UPDATE CART SUCCESSFULLY")
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
    }
    
    func deleteById(cart_id: Int32){
        var cartModel = CartModel()
        let query = String(format: cartModel.queryDeleteCartById, cart_id)
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            print("DELETE CART SUCCESSFULLY")
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
    }
    
    func getCartByCustomerId(cart_cust_id: Int32) -> [CartModel]? { //Need return list of CartObj
            
        var cartArray : [CartModel] = []
        var cartModel = CartModel()
        let query = String(format: cartModel.queryGetCartByCustomerId, cart_cust_id)
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            while rs.next() {
                cartModel = CartModel()
                cartModel.cart_id = rs.intForColumn("cart_id")
                cartModel.cart_user_id = rs.intForColumn("cart_user_id")
                cartModel.cart_cust_id = rs.intForColumn("cart_cust_id")
                cartModel.cart_prod_id = rs.intForColumn("cart_prod_id")
                cartModel.cart_quantity = rs.intForColumn("cart_quantity")
                cartModel.cart_pickup_now = rs.stringForColumn("cart_pickup_now")
                cartModel.cart_current_location = rs.stringForColumn("cart_current_location")
                cartModel.cart_create_date = rs.dateForColumn("cart_create_date")
                cartModel.cart_update_date = rs.dateForColumn("cart_update_date")
                
                cartArray.append(cartModel)
            }
            return cartArray
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
        return nil
        
        
    }
    
}