//
//  ProductGroupController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class ProductGroupController{
    var database:FMDatabase!
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getProductGroupById(prog_id : Int32) -> ProductGroupModel { //Need return ProductGroupObj
        var prodGroup = ProductGroupModel()
        let prodGroupQuery = String(format: prodGroup.queryGetProductGroupById, prog_id)
        print(prodGroupQuery)
        if let rs = database.executeQuery(prodGroupQuery, withArgumentsInArray: nil) {
            while rs.next(){
                print("1")
                prodGroup = ProductGroupModel()
                prodGroup.prog_id = rs.intForColumn("prog_id")
                prodGroup.prog_name = rs.stringForColumn("prog_name")
                print("2")
          //      prodGroup.prog_create_date = rs.dateForColumn("prog_create_date")
          //      prodGroup.prog_update_date = rs.dateForColumn("prog_update_date")
                break;
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return prodGroup
    }
    
    func getAllProductGroup() -> [ProductGroupModel]{ //Need return list of ProductGroupObj
        var productGroupArray:[ProductGroupModel] = []
        var allProdGrouplist = ProductGroupModel()
        let prodGroupQuery = String("SELECT * FROM PRODUCT_GROUP")
        print(prodGroupQuery)
        if let rs = database.executeQuery(prodGroupQuery, withArgumentsInArray: nil) {
            while rs.next(){
                allProdGrouplist = ProductGroupModel()
                allProdGrouplist.prog_id = rs.intForColumn("prog_id")
                allProdGrouplist.prog_name = rs.stringForColumn("prog_name")
           //     allProdGrouplist.prog_create_date = rs.dateForColumn("prog_create_date")
           //     allProdGrouplist.prog_update_date = rs.dateForColumn("prog_update_date")
                productGroupArray.append(allProdGrouplist)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return productGroupArray
        
    }

}