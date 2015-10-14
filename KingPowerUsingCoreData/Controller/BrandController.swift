//
//  BrandController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class BrandController{
    var database:FMDatabase!
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getBrandById(bran_id : Int32) -> BrandModel { //Need return brandObj
        let brand = BrandModel()
        //let brandQuery = String("SELECT * FROM BRAND WHERE bran_id = 1")
        let brandQuery = String(format: "SELECT * FROM BRAND WHERE bran_id = %d", bran_id)
        //print(brandQuery)
        if let rs = database.executeQuery(brandQuery, withArgumentsInArray: nil) {
            while rs.next(){
                brand.bran_id = rs.intForColumn("bran_id")
                brand.bran_name = rs.stringForColumn("bran_name")
                brand.bran_create_date = rs.dateForColumn("bran_create_date")
                brand.bran_update_date = rs.dateForColumn("bran_update_date")
                break;
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return brand
    }
    
    func getAllBrand() -> [BrandModel]{ //Need return list of brandObj
        var brandArray:[BrandModel] = []
        var allBrandlist = BrandModel()
        let brandQuery = String(format: allBrandlist.queryGetBrandAll)
        print(brandQuery)
        if let rs = database.executeQuery(brandQuery, withArgumentsInArray: nil) {
            while rs.next(){
                allBrandlist = BrandModel()
                allBrandlist.bran_id = rs.intForColumn("bran_id")
                allBrandlist.bran_name = rs.stringForColumn("bran_name")
                allBrandlist.bran_create_date = rs.dateForColumn("bran_create_date")
                allBrandlist.bran_update_date = rs.dateForColumn("bran_update_date")
                brandArray.append(allBrandlist)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return brandArray

    }
    
    func getBrandByGroupId(group_id:Int32) -> [BrandModel]{ //Need return list of brandObj
        var brandArray:[BrandModel] = []
        var allBrandlist = BrandModel()
        let brandQuery = String(format: allBrandlist.queryGetBrandByProdGroupId, group_id)
        print(brandQuery)
        if let rs = database.executeQuery(brandQuery, withArgumentsInArray: nil) {
            while rs.next(){
                allBrandlist = BrandModel()
                allBrandlist.bran_id = rs.intForColumn("bran_id")
                allBrandlist.bran_name = rs.stringForColumn("bran_name")
                allBrandlist.bran_create_date = rs.dateForColumn("bran_create_date")
                allBrandlist.bran_update_date = rs.dateForColumn("bran_update_date")
                brandArray.append(allBrandlist)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return brandArray
        
    }

}