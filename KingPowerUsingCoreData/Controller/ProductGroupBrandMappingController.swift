//
//  ProductGroupBrandMappingController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation


class ProductGroupBrandMappingController{
    var database:FMDatabase!
    var brandController = BrandController()
    var productGroupController = ProductGroupController()
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getBrandByProductGroupId(prog_id:Int32) -> [ProductGroupBrandMapModel]{
        var prodGroupBrandArray:[ProductGroupBrandMapModel] = []
        let prodGroupBrand = ProductGroupBrandMapModel()
        let prodGroupBrandQuery = String(format: "SELECT * FROM PRODUCT_GROUP_BRAND_MAP WHERE prbm_prog_id = %@", prog_id)
        print(prodGroupBrandQuery)
        if let rs = database.executeQuery(prodGroupBrandQuery, withArgumentsInArray: nil) {
            while rs.next(){
                prodGroupBrand.prbm_id = rs.intForColumn("prbm_id")
                prodGroupBrand.prbm_bran_id = rs.intForColumn("prbm_bran_id")
                prodGroupBrand.prbm_prog_id = rs.intForColumn("prbm_prog_id")
                prodGroupBrand.prbm_create_date = rs.dateForColumn("prbm_create_date")
                prodGroupBrand.prbm_update_date = rs.dateForColumn("prbm_update_date")
                prodGroupBrand.prbm_bran = brandController.getBrandById(prodGroupBrand.prbm_bran_id)
                prodGroupBrand.prbm_prog = productGroupController.getProductGroupById(prodGroupBrand.prbm_prog_id)
                prodGroupBrandArray.append(prodGroupBrand)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return prodGroupBrandArray
    }
    
    func getProductGroupByBrandId(bran_id:Int32) -> [ProductGroupBrandMapModel]{ //Need return
        var prodGroupBrandArray:[ProductGroupBrandMapModel] = []
        let prodGroupBrand = ProductGroupBrandMapModel()
        let prodGroupBrandQuery = String(format: "SELECT * FROM PRODUCT_GROUP_BRAND_MAP WHERE prbm_bran_id = %@", bran_id)
        print(prodGroupBrandQuery)
        if let rs = database.executeQuery(prodGroupBrandQuery, withArgumentsInArray: nil) {
            while rs.next(){
                prodGroupBrand.prbm_id = rs.intForColumn("prbm_id")
                prodGroupBrand.prbm_bran_id = rs.intForColumn("prbm_bran_id")
                prodGroupBrand.prbm_prog_id = rs.intForColumn("prbm_prog_id")
                prodGroupBrand.prbm_create_date = rs.dateForColumn("prbm_create_date")
                prodGroupBrand.prbm_update_date = rs.dateForColumn("prbm_update_date")
                prodGroupBrand.prbm_bran = brandController.getBrandById(prodGroupBrand.prbm_bran_id)
                prodGroupBrand.prbm_prog = productGroupController.getProductGroupById(prodGroupBrand.prbm_prog_id)
                prodGroupBrandArray.append(prodGroupBrand)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return prodGroupBrandArray
    }
    
}