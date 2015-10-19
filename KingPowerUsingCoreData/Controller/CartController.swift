//
//  CartController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class CartController{
    var productController = ProductController()
    var database:FMDatabase!
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func insert(cart_user_id: Int32, cart_cust_id: Int32, cart_prod_id: Int32, cart_quantity: Int32, cart_pickup_now: String, cart_current_location: String, cart_create_date: String, cart_update_date: String){
        
        var cartModel = CartModel()
        let cartId = getMaxCartId() + 1
        
        let query = String(format: cartModel.queryInsertCart, cartId, cart_user_id, cart_cust_id, cart_prod_id, cart_quantity, cart_pickup_now, cart_current_location, cart_create_date, cart_update_date)
        let updateSuccessful = database.executeUpdate(query, withArgumentsInArray: nil)
        if updateSuccessful {
            print("UPDATE CART SUCCESSFULLY")
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            
        }
    }
    
    func updateById(cart_id: Int32, cart_quantity: Int32, cart_pickup_now: String, cart_update_date: String){ //Need
        var cartModel = CartModel()
        let query = String(format: cartModel.queryUpdatecartById, cart_quantity, cart_pickup_now, cart_update_date, cart_id)
        
        let updateSuccessful = database.executeUpdate(query, withArgumentsInArray: nil)
        if updateSuccessful {
            print("UPDATE CART SUCCESSFULLY")
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
    }
    
    func deleteByCustomerId(cust_id: Int32, user_id : Int32){
        var cartModel = CartModel()
        
        let query = String(format: cartModel.queryDeleteCartById, cust_id, user_id)
        let deleteSuccessful = database.executeUpdate(query, withArgumentsInArray: nil)
        if !deleteSuccessful {
            print("DELETE CART SUCCESSFULLY")
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
    }
    func deleteByCartId(cart_id : Int32){
        var cartModel = CartModel()
        
        let query = String(format: cartModel.queryDeleteCartByCartId, cart_id)
        let deleteSuccessful = database.executeUpdate(query, withArgumentsInArray: nil)
        if !deleteSuccessful {
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
                cartModel.cart_prod = productController.getProductByID(cartModel.cart_prod_id)
                cartArray.append(cartModel)
            }
            return cartArray
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
        
    }
    
    func getCartPickTypeByCustomerId(cart_cust_id: Int32, cart_pickup_now: String) -> [CartModel]? { //Need return list of CartObj
        
        var cartArray : [CartModel] = []
        var cartModel = CartModel()
        let query = String(format: cartModel.queryGetCartPickTypeByCustomerId, cart_cust_id, cart_pickup_now)
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
                cartModel.cart_prod = productController.getProductByID(cartModel.cart_prod_id)
                cartArray.append(cartModel)
            }
            return cartArray
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
        
    }
    
    func getMaxCartId() -> Int32{
        var cartModel = CartModel()
        var maxId : Int32 = 0
        let queryGetMaxId = String(format: cartModel.queryGetMaxId)
        if let rs = database.executeQuery(queryGetMaxId, withArgumentsInArray: nil){
            while rs.next() {
                maxId = rs.intForColumn("max_col")
                break;
            }
        }
        return maxId
    }
    
}