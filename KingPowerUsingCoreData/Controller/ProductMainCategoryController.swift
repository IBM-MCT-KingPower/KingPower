//
//  ProductMainCategoryController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class ProductMainCategoryController{
    var database:FMDatabase!
    var productGroupController = ProductGroupController()
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getProductMainCategoryByProductMainId(parent_category_id:Int32) -> ProductCategoryModel { //Need return list of ProductMainCategory
        var prodCat = ProductCategoryModel()
        let prodCatQuery = String(format: "SELECT * FROM PRODUCT_CATEGORY WHERE prc_id = %d", parent_category_id)
        print(prodCatQuery)
        if let rs = database.executeQuery(prodCatQuery, withArgumentsInArray: nil) {
            while rs.next(){
                prodCat = ProductCategoryModel()
                prodCat.prc_id = rs.intForColumn("prc_id")
                prodCat.prc_prog_id = rs.intForColumn("prc_prog_id")
                prodCat.prc_name = rs.stringForColumn("prc_name")
                prodCat.prc_parent_category_id = rs.intForColumn("prc_parent_category_id")
                prodCat.prc_create_date = rs.dateForColumn("prc_create_date")
                prodCat.prc_update_date = rs.dateForColumn("prc_update_date")
                prodCat.prc_prog = productGroupController.getProductGroupById(prodCat.prc_prog_id)
                if prodCat.prc_parent_category_id != 0 {
                    prodCat.prc_parent_category = getProductMainCategoryByProductMainId(prodCat.prc_parent_category_id)
                }
                break;
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return prodCat

    }
    
    func getProductMainCategoryByProductGroupId(prog_id:Int32) -> [ProductCategoryModel]{ //Need return list of ProductMainCategory
        var prodCatArray:[ProductCategoryModel] = []
        var prodCat = ProductCategoryModel()
        let prodCatQuery = String(format: prodCat.queryGetProductCategoryByProductGroupId, prog_id)
        print(prodCatQuery)
        if let rs = database.executeQuery(prodCatQuery, withArgumentsInArray: nil) {
            while rs.next(){
                prodCat = ProductCategoryModel()
                prodCat.prc_id = rs.intForColumn("prc_id")
                prodCat.prc_prog_id = rs.intForColumn("prc_prog_id")
                prodCat.prc_name = rs.stringForColumn("prc_name")
                prodCat.prc_parent_category_id = rs.intForColumn("prc_parent_category_id")
                prodCat.prc_create_date = rs.dateForColumn("prc_create_date")
                prodCat.prc_update_date = rs.dateForColumn("prc_update_date")
                prodCat.prc_prog = productGroupController.getProductGroupById(prodCat.prc_prog_id)
                if prodCat.prc_parent_category_id != 0 {
                    prodCat.prc_parent_category = getProductMainCategoryByProductMainId(prodCat.prc_parent_category_id)
                }
                prodCatArray.append(prodCat)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return prodCatArray
    }
    
    func getAllProductMainCategory() -> [ProductCategoryModel] { //Need return list of ProductMainCategory
        var prodCatArray:[ProductCategoryModel] = []
        var prodCat = ProductCategoryModel()
        let prodCatQuery = String(format: prodCat.queryGetProductCategoryAll)
        print(prodCatQuery)
        if let rs = database.executeQuery(prodCatQuery, withArgumentsInArray: nil) {
            while rs.next(){
                prodCat = ProductCategoryModel()
                prodCat.prc_id = rs.intForColumn("prc_id")
                prodCat.prc_prog_id = rs.intForColumn("prc_prog_id")
                prodCat.prc_name = rs.stringForColumn("prc_name")
                prodCat.prc_parent_category_id = rs.intForColumn("prc_parent_category_id")
                prodCat.prc_create_date = rs.dateForColumn("prc_create_date")
                prodCat.prc_update_date = rs.dateForColumn("prc_update_date")
                prodCat.prc_prog = productGroupController.getProductGroupById(prodCat.prc_prog_id)
                if prodCat.prc_parent_category_id != 0 {
                    prodCat.prc_parent_category = getProductMainCategoryByProductMainId(prodCat.prc_parent_category_id)
                }
                prodCatArray.append(prodCat)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return prodCatArray

    }
}