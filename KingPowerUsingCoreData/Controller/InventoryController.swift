//
//  InventoryController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class InventoryController{
    var database:FMDatabase!
    var brandArray:[BrandModel] = []
    
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func checkProductAvailable(prod_id:Int32, required_amount:Int32, ware_id:Int32) -> Bool { //Need return bool
        //product id, required amount, warehouse
        var avaiAmount:Int32 = 0
        let inventoryQuery = String("SELECT * FROM INVENTORY")
        print(inventoryQuery)
        if let rs = database.executeQuery(inventoryQuery, withArgumentsInArray: nil) {
            while rs.next(){
                avaiAmount = rs.intForColumn("invt_avai_quantity")
                break;
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        if avaiAmount < required_amount {
            return false
        }else {
            return true
        }
    }
    
    func updateInventory(inventory:InventoryModel) -> Bool { //
        let insertSQL = ""
        let result = database.executeUpdate(insertSQL, withArgumentsInArray: nil)
        if !result {
            print("update failed: \(database.lastErrorMessage())", terminator: "")
            return false
        } else {
            return true
        }
    }
    
}