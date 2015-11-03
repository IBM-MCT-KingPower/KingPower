//
//  ProductController.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 10/6/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import Foundation

class ProductController {
    
    var database:FMDatabase!
    var productImgController = ProductImageController()
    var brandController = BrandController()
    var productCategoryController = ProductMainCategoryController()
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getProductByID(prod_id:Int32) -> ProductModel{
        let product = ProductModel()
        let prodQuery = String("SELECT * FROM PRODUCT where prod_id = \(prod_id) ORDER BY prod_name ASC")
        //print(prodQuery)
        if let rs = database.executeQuery(prodQuery, withArgumentsInArray: nil) {
            while rs.next(){
                product.prod_id = rs.intForColumn("prod_id")
                product.prod_code = rs.stringForColumn("prod_code")
                product.prod_name = rs.stringForColumn("prod_name")
                product.prod_type = rs.stringForColumn("prod_type")
                product.prod_price = rs.doubleForColumn("prod_price")
                product.prod_discount_price = rs.doubleForColumn("prod_discount_price")
                product.prod_description = rs.stringForColumn("prod_description")
                product.prod_details = rs.stringForColumn("prod_details")
                product.prod_remark = rs.stringForColumn("prod_remark") == nil ? "":rs.stringForColumn("prod_remark")
                product.prod_flight_only = rs.stringForColumn("prod_flight_only")
                product.prod_in_stock = rs.stringForColumn("prod_in_stock")
                product.prod_sale = rs.stringForColumn("prod_sale")
                product.prod_weight = rs.doubleForColumn("prod_weight")
                product.prod_width = rs.doubleForColumn("prod_width")
                product.prod_height = rs.doubleForColumn("prod_height")
                product.prod_depth = rs.doubleForColumn("prod_depth")
                product.prod_color = String(rs.stringForColumn("prod_color"))
                product.prod_gender = rs.stringForColumn("prod_gender")
                product.prod_bran_id = rs.intForColumn("prod_bran_id")
                product.prod_prc_id = rs.intForColumn("prod_prc_id")
                product.prod_rating = rs.intForColumn("prod_rating")
                product.prod_create_date = rs.dateForColumn("prod_create_date")
                product.prod_update_date = rs.dateForColumn("prod_update_date")
                product.prod_arrival_flag = rs.stringForColumn("prod_arrival_flag") == nil ? "":rs.stringForColumn("prod_arrival_flag")
                product.prod_imageArray = productImgController.getProductImageByProductId(product.prod_id)//getProductImage(product.prod_id )
                product.prod_bran = brandController.getBrandById(product.prod_bran_id)
                break;
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        
        return product
    }
    
    func getProductByOrder(fieldname: String,sort: String)->[ProductModel]{
        var productArray:[ProductModel] = []
        var prodbyOrderlist = ProductModel()
        let prodQuery = String(format: prodbyOrderlist.queryProductAll, fieldname, sort)
        print(prodQuery)
        if let rs = database.executeQuery(prodQuery, withArgumentsInArray: nil) {
            while rs.next(){
                prodbyOrderlist = ProductModel()
                prodbyOrderlist.prod_id = rs.intForColumn("prod_id")
                prodbyOrderlist.prod_code = rs.stringForColumn("prod_code")
                prodbyOrderlist.prod_name = rs.stringForColumn("prod_name")
                prodbyOrderlist.prod_type = rs.stringForColumn("prod_type")
                prodbyOrderlist.prod_price = rs.doubleForColumn("prod_price")
                prodbyOrderlist.prod_discount_price = rs.doubleForColumn("prod_discount_price")
                prodbyOrderlist.prod_description = rs.stringForColumn("prod_description")
                prodbyOrderlist.prod_details = rs.stringForColumn("prod_details")
                prodbyOrderlist.prod_remark = rs.stringForColumn("prod_remark") == nil ? "":rs.stringForColumn("prod_remark")
                prodbyOrderlist.prod_flight_only = rs.stringForColumn("prod_flight_only")
                prodbyOrderlist.prod_in_stock = rs.stringForColumn("prod_in_stock")
                prodbyOrderlist.prod_sale = rs.stringForColumn("prod_sale")
                prodbyOrderlist.prod_weight = rs.doubleForColumn("prod_weight")
                prodbyOrderlist.prod_width = rs.doubleForColumn("prod_width")
                prodbyOrderlist.prod_height = rs.doubleForColumn("prod_height")
                prodbyOrderlist.prod_depth = rs.doubleForColumn("prod_depth")
                prodbyOrderlist.prod_color = String(rs.stringForColumn("prod_color"))
                prodbyOrderlist.prod_gender = rs.stringForColumn("prod_gender")
                prodbyOrderlist.prod_bran_id = rs.intForColumn("prod_bran_id")
                prodbyOrderlist.prod_prc_id = rs.intForColumn("prod_prc_id")
                prodbyOrderlist.prod_rating = rs.intForColumn("prod_rating")
                prodbyOrderlist.prod_create_date = rs.dateForColumn("prod_create_date")
                prodbyOrderlist.prod_update_date = rs.dateForColumn("prod_update_date")
                prodbyOrderlist.prod_arrival_flag = rs.stringForColumn("prod_arrival_flag") == nil ? "":rs.stringForColumn("prod_arrival_flag")
                prodbyOrderlist.prod_imageArray = productImgController.getProductImageByProductId(prodbyOrderlist.prod_id)//getProductImage(prodbyOrderlist.prod_id )
                prodbyOrderlist.prod_bran = brandController.getBrandById(prodbyOrderlist.prod_bran_id)
                productArray.append(prodbyOrderlist)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return productArray
    }
    func getAllProduct()->[ProductModel]{
        var productArray:[ProductModel] = []
        var prodbyOrderlist = ProductModel()
        let prodQuery = String("SELECT * FROM PRODUCT")
        print(prodQuery)
        if let rs = database.executeQuery(prodQuery, withArgumentsInArray: nil) {
            while rs.next(){
                prodbyOrderlist = ProductModel()
                prodbyOrderlist.prod_id = rs.intForColumn("prod_id")
                prodbyOrderlist.prod_code = rs.stringForColumn("prod_code")
                prodbyOrderlist.prod_name = rs.stringForColumn("prod_name")
                prodbyOrderlist.prod_type = rs.stringForColumn("prod_type")
                prodbyOrderlist.prod_price = rs.doubleForColumn("prod_price")
                prodbyOrderlist.prod_discount_price = rs.doubleForColumn("prod_discount_price")
                prodbyOrderlist.prod_description = rs.stringForColumn("prod_description")
                prodbyOrderlist.prod_details = rs.stringForColumn("prod_details")
                prodbyOrderlist.prod_remark = rs.stringForColumn("prod_remark") == nil ? "":rs.stringForColumn("prod_remark")
                prodbyOrderlist.prod_flight_only = rs.stringForColumn("prod_flight_only")
                prodbyOrderlist.prod_in_stock = rs.stringForColumn("prod_in_stock")
                prodbyOrderlist.prod_sale = rs.stringForColumn("prod_sale")
                prodbyOrderlist.prod_weight = rs.doubleForColumn("prod_weight")
                prodbyOrderlist.prod_width = rs.doubleForColumn("prod_width")
                prodbyOrderlist.prod_height = rs.doubleForColumn("prod_height")
                prodbyOrderlist.prod_depth = rs.doubleForColumn("prod_depth")
                prodbyOrderlist.prod_color = String(rs.stringForColumn("prod_color"))
                prodbyOrderlist.prod_gender = rs.stringForColumn("prod_gender")
                prodbyOrderlist.prod_bran_id = rs.intForColumn("prod_bran_id")
                prodbyOrderlist.prod_prc_id = rs.intForColumn("prod_prc_id")
                prodbyOrderlist.prod_rating = rs.intForColumn("prod_rating")
                prodbyOrderlist.prod_create_date = rs.dateForColumn("prod_create_date")
                prodbyOrderlist.prod_update_date = rs.dateForColumn("prod_update_date")
                prodbyOrderlist.prod_arrival_flag = rs.stringForColumn("prod_arrival_flag") == nil ? "":rs.stringForColumn("prod_arrival_flag")
                prodbyOrderlist.prod_bran = brandController.getBrandById(prodbyOrderlist.prod_bran_id)
                prodbyOrderlist.prod_imageArray = productImgController.getProductImageByProductId(prodbyOrderlist.prod_id)//getProductImage(prodbyOrderlist.prod_id )
                prodbyOrderlist.prod_prc = productCategoryController.getProductMainCategoryByProductMainId(prodbyOrderlist.prod_prc_id)
                productArray.append(prodbyOrderlist)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return productArray
    }
    func getProductByProductGroupID(prog_id:Int32) -> [ProductModel]{
        var productArray:[ProductModel] = []
        var product = ProductModel()
        let prodQuery = String(format: product.queryProductByProductGroupId, prog_id, "prod_name", "ASC")//String("SELECT * FROM PRODUCT where prod_id = \(prod_id) ORDER BY prod_name ASC")
        print(prodQuery)
        if let rs = database.executeQuery(prodQuery, withArgumentsInArray: nil) {
            while rs.next(){
                product = ProductModel()
                product.prod_id = rs.intForColumn("prod_id")
                product.prod_code = rs.stringForColumn("prod_code")
                product.prod_name = rs.stringForColumn("prod_name")
                //print("Product Name from Query : \(product.prod_name)")
                product.prod_type = rs.stringForColumn("prod_type")
                product.prod_price = rs.doubleForColumn("prod_price")
                product.prod_discount_price = rs.doubleForColumn("prod_discount_price")
                product.prod_description = rs.stringForColumn("prod_description")
                product.prod_details = rs.stringForColumn("prod_details")
                product.prod_remark = rs.stringForColumn("prod_remark") == nil ? "":rs.stringForColumn("prod_remark")
                product.prod_flight_only = rs.stringForColumn("prod_flight_only")
                product.prod_in_stock = rs.stringForColumn("prod_in_stock")
                product.prod_sale = rs.stringForColumn("prod_sale")
                product.prod_weight = rs.doubleForColumn("prod_weight")
                product.prod_width = rs.doubleForColumn("prod_width")
                product.prod_height = rs.doubleForColumn("prod_height")
                product.prod_depth = rs.doubleForColumn("prod_depth")
                product.prod_color = String(rs.stringForColumn("prod_color"))
                product.prod_gender = rs.stringForColumn("prod_gender")
                product.prod_bran_id = rs.intForColumn("prod_bran_id")
                product.prod_prc_id = rs.intForColumn("prod_prc_id")
                product.prod_rating = rs.intForColumn("prod_rating")
                product.prod_create_date = rs.dateForColumn("prod_create_date")
                product.prod_update_date = rs.dateForColumn("prod_update_date")
                product.prod_arrival_flag = rs.stringForColumn("prod_arrival_flag") == nil ? "":rs.stringForColumn("prod_arrival_flag")
                product.prod_imageArray = productImgController.getProductImageByProductId(product.prod_id)
                product.prod_bran = brandController.getBrandById(product.prod_bran_id)
                productArray.append(product)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return productArray
    }
    
    func getProductByProductGroupIDWithLimit(prog_id:Int32) -> [ProductModel]{
        var productArray:[ProductModel] = []
        var product = ProductModel()
        let prodQuery = String(format: product.queryProductByProductGroupId, prog_id, "prod_name", "ASC")//String("SELECT * FROM PRODUCT where prod_id = \(prod_id) ORDER BY prod_name ASC")
        print(prodQuery)
        if let rs = database.executeQuery(prodQuery, withArgumentsInArray: nil) {
            while rs.next(){
                product = ProductModel()
                product.prod_id = rs.intForColumn("prod_id")
                product.prod_code = rs.stringForColumn("prod_code")
                product.prod_name = rs.stringForColumn("prod_name")
                //print("Product Name from Query : \(product.prod_name)")
                product.prod_type = rs.stringForColumn("prod_type")
                product.prod_price = rs.doubleForColumn("prod_price")
                product.prod_discount_price = rs.doubleForColumn("prod_discount_price")
                product.prod_description = rs.stringForColumn("prod_description")
                product.prod_details = rs.stringForColumn("prod_details")
                product.prod_remark = rs.stringForColumn("prod_remark") == nil ? "":rs.stringForColumn("prod_remark")
                product.prod_flight_only = rs.stringForColumn("prod_flight_only")
                product.prod_in_stock = rs.stringForColumn("prod_in_stock")
                product.prod_sale = rs.stringForColumn("prod_sale")
                product.prod_weight = rs.doubleForColumn("prod_weight")
                product.prod_width = rs.doubleForColumn("prod_width")
                product.prod_height = rs.doubleForColumn("prod_height")
                product.prod_depth = rs.doubleForColumn("prod_depth")
                product.prod_color = String(rs.stringForColumn("prod_color"))
                product.prod_gender = rs.stringForColumn("prod_gender")
                product.prod_bran_id = rs.intForColumn("prod_bran_id")
                product.prod_prc_id = rs.intForColumn("prod_prc_id")
                product.prod_rating = rs.intForColumn("prod_rating")
                product.prod_create_date = rs.dateForColumn("prod_create_date")
                product.prod_update_date = rs.dateForColumn("prod_update_date")
                product.prod_arrival_flag = rs.stringForColumn("prod_arrival_flag") == nil ? "":rs.stringForColumn("prod_arrival_flag")
                product.prod_imageArray = productImgController.getProductImageByProductId(product.prod_id)
                product.prod_bran = brandController.getBrandById(product.prod_bran_id)
                productArray.append(product)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return productArray
    }

    func getProductByGender(prod_gender:String) -> [ProductModel]{
        var productArray:[ProductModel] = []
        var product = ProductModel()
        let prodQuery = String(format: product.queryProductByGenderWithLimit, prod_gender, "prod_name", "ASC")
        print(prodQuery)
        if let rs = database.executeQuery(prodQuery, withArgumentsInArray: nil) {
            while rs.next(){
                product = ProductModel()
                product.prod_id = rs.intForColumn("prod_id")
                product.prod_code = rs.stringForColumn("prod_code")
                product.prod_name = rs.stringForColumn("prod_name")
                print("Product Name from Query : \(product.prod_name)")
                product.prod_type = rs.stringForColumn("prod_type")
                product.prod_price = rs.doubleForColumn("prod_price")
                product.prod_discount_price = rs.doubleForColumn("prod_discount_price")
                product.prod_description = rs.stringForColumn("prod_description")
                product.prod_details = rs.stringForColumn("prod_details")
                product.prod_remark = rs.stringForColumn("prod_remark") == nil ? "":rs.stringForColumn("prod_remark")
                product.prod_flight_only = rs.stringForColumn("prod_flight_only")
                product.prod_in_stock = rs.stringForColumn("prod_in_stock")
                product.prod_sale = rs.stringForColumn("prod_sale")
                product.prod_weight = rs.doubleForColumn("prod_weight")
                product.prod_width = rs.doubleForColumn("prod_width")
                product.prod_height = rs.doubleForColumn("prod_height")
                product.prod_depth = rs.doubleForColumn("prod_depth")
                product.prod_color = String(rs.stringForColumn("prod_color"))
                product.prod_gender = rs.stringForColumn("prod_gender")
                product.prod_bran_id = rs.intForColumn("prod_bran_id")
                product.prod_prc_id = rs.intForColumn("prod_prc_id")
                product.prod_rating = rs.intForColumn("prod_rating")
                product.prod_create_date = rs.dateForColumn("prod_create_date")
                product.prod_update_date = rs.dateForColumn("prod_update_date")
                product.prod_arrival_flag = rs.stringForColumn("prod_arrival_flag") == nil ? "":rs.stringForColumn("prod_arrival_flag") == nil ? "":rs.stringForColumn("prod_arrival_flag")
                product.prod_imageArray = productImgController.getProductImageByProductId(product.prod_id)
                product.prod_bran = brandController.getBrandById(product.prod_bran_id)
                productArray.append(product)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return productArray
    }
    
    func getProductByGenderWithLimit(prod_gender:String) -> [ProductModel]{
        var productArray:[ProductModel] = []
        var product = ProductModel()
        let prodQuery = String(format: product.queryProductByGenderWithLimit, prod_gender, "PROD_NAME", "ASC")
        print(prodQuery)
        if let rs = database.executeQuery(prodQuery, withArgumentsInArray: nil) {
            while rs.next(){
                product = ProductModel()
                product.prod_id = rs.intForColumn("prod_id")
                product.prod_code = rs.stringForColumn("prod_code")
                product.prod_name = rs.stringForColumn("prod_name")
                print("Product Name from Query : \(product.prod_name)")
                product.prod_type = rs.stringForColumn("prod_type")
                product.prod_price = rs.doubleForColumn("prod_price")
                product.prod_discount_price = rs.doubleForColumn("prod_discount_price")
                product.prod_description = rs.stringForColumn("prod_description")
                product.prod_details = rs.stringForColumn("prod_details")
                product.prod_remark = rs.stringForColumn("prod_remark") == nil ? "":rs.stringForColumn("prod_remark")
                product.prod_flight_only = rs.stringForColumn("prod_flight_only")
                product.prod_in_stock = rs.stringForColumn("prod_in_stock")
                product.prod_sale = rs.stringForColumn("prod_sale")
                product.prod_weight = rs.doubleForColumn("prod_weight")
                product.prod_width = rs.doubleForColumn("prod_width")
                product.prod_height = rs.doubleForColumn("prod_height")
                product.prod_depth = rs.doubleForColumn("prod_depth")
                product.prod_color = String(rs.stringForColumn("prod_color"))
                product.prod_gender = rs.stringForColumn("prod_gender")
                product.prod_bran_id = rs.intForColumn("prod_bran_id")
                product.prod_prc_id = rs.intForColumn("prod_prc_id")
                product.prod_rating = rs.intForColumn("prod_rating")
                product.prod_create_date = rs.dateForColumn("prod_create_date")
                product.prod_update_date = rs.dateForColumn("prod_update_date")
                product.prod_arrival_flag = rs.stringForColumn("prod_arrival_flag") == nil ? "":rs.stringForColumn("prod_arrival_flag") == nil ? "":rs.stringForColumn("prod_arrival_flag")
                product.prod_imageArray = productImgController.getProductImageByProductId(product.prod_id)
                product.prod_bran = brandController.getBrandById(product.prod_bran_id)
                productArray.append(product)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return productArray
    }
    
    func getProductByGorupCatBranName(selectedText:String) -> [ProductModel]{
        var productArray:[ProductModel] = []
        var product = ProductModel()
        let prodQuery = String(format: product.queryProductByGroupCatBranName, selectedText, selectedText, selectedText)
        print(prodQuery)
        if let rs = database.executeQuery(prodQuery, withArgumentsInArray: nil) {
            while rs.next(){
                product = ProductModel()
                product.prod_id = rs.intForColumn("prod_id")
                product.prod_code = rs.stringForColumn("prod_code")
                product.prod_name = rs.stringForColumn("prod_name")
                print("Product Name from Query : \(product.prod_name)")
                product.prod_type = rs.stringForColumn("prod_type")
                product.prod_price = rs.doubleForColumn("prod_price")
                product.prod_discount_price = rs.doubleForColumn("prod_discount_price")
                product.prod_description = rs.stringForColumn("prod_description")
                product.prod_details = rs.stringForColumn("prod_details")
                product.prod_remark = rs.stringForColumn("prod_remark") == nil ? "":rs.stringForColumn("prod_remark")
                product.prod_flight_only = rs.stringForColumn("prod_flight_only")
                product.prod_in_stock = rs.stringForColumn("prod_in_stock")
                product.prod_sale = rs.stringForColumn("prod_sale")
                product.prod_weight = rs.doubleForColumn("prod_weight")
                product.prod_width = rs.doubleForColumn("prod_width")
                product.prod_height = rs.doubleForColumn("prod_height")
                product.prod_depth = rs.doubleForColumn("prod_depth")
                product.prod_color = String(rs.stringForColumn("prod_color"))
                product.prod_gender = rs.stringForColumn("prod_gender")
                product.prod_bran_id = rs.intForColumn("prod_bran_id")
                product.prod_prc_id = rs.intForColumn("prod_prc_id")
                product.prod_rating = rs.intForColumn("prod_rating")
                product.prod_create_date = rs.dateForColumn("prod_create_date")
                product.prod_update_date = rs.dateForColumn("prod_update_date")
                product.prod_arrival_flag = rs.stringForColumn("prod_arrival_flag") == nil ? "":rs.stringForColumn("prod_arrival_flag") == nil ? "":rs.stringForColumn("prod_arrival_flag")
                product.prod_imageArray = productImgController.getProductImageByProductId(product.prod_id)
                product.prod_bran = brandController.getBrandById(product.prod_bran_id)
                productArray.append(product)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return productArray
    }

    
    func getProductRelatedByProdId(prod_id:Int32) -> [ProductModel]{
        var productArray:[ProductModel] = []
        var productRelate = ProductRelateModel()
        let prodRelQuery = String(format: productRelate.queryProductRelateByMainID, prod_id)
        if let rs = database.executeQuery(prodRelQuery, withArgumentsInArray: nil) {
            while rs.next(){
                productRelate = ProductRelateModel()
                productRelate.pror_relate_prod_id = rs.intForColumn("pror_relate_prod_id")
                productRelate.pror_relate_prod = self.getProductByID(productRelate.pror_relate_prod_id)
                productArray.append(productRelate.pror_relate_prod)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return productArray
    }

    
    func getProductRecommendByProdId(prod_id:Int32) -> [ProductModel]{
        var productArray:[ProductModel] = []
        var productRecommend = ProductRecommendModel()
        let prodRecQuery = String(format: productRecommend.queryProductRecommendByMainID, prod_id)
        if let rs = database.executeQuery(prodRecQuery, withArgumentsInArray: nil) {
            while rs.next(){
                productRecommend = ProductRecommendModel()
                productRecommend.prre_recom_prod_id = rs.intForColumn("prre_recom_prod_id")
                productRecommend.prre_recom_prod = self.getProductByID(productRecommend.prre_recom_prod_id)
                productArray.append(productRecommend.prre_recom_prod)
            }
        } else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return productArray
    }
    
    func getProductByBrandId(bran_id: Int32) -> [ProductModel] {
        var productArray:[ProductModel] = []
        var product = ProductModel()
        let prodQuery = String(format: product.queryProductByProductGroupId, bran_id, "prod_name", "ASC")//String("SELECT * FROM PRODUCT where prod_id = \(prod_id) ORDER BY prod_name ASC")
        print(prodQuery)
        if let rs = database.executeQuery(prodQuery, withArgumentsInArray: nil) {
            while rs.next(){
                product = ProductModel()
                product.prod_id = rs.intForColumn("prod_id")
                product.prod_code = rs.stringForColumn("prod_code")
                product.prod_name = rs.stringForColumn("prod_name")
                //print("Product Name from Query : \(product.prod_name)")
                product.prod_type = rs.stringForColumn("prod_type")
                product.prod_price = rs.doubleForColumn("prod_price")
                product.prod_discount_price = rs.doubleForColumn("prod_discount_price")
                product.prod_description = rs.stringForColumn("prod_description")
                product.prod_details = rs.stringForColumn("prod_details")
                product.prod_remark = rs.stringForColumn("prod_remark") == nil ? "":rs.stringForColumn("prod_remark")
                product.prod_flight_only = rs.stringForColumn("prod_flight_only")
                product.prod_in_stock = rs.stringForColumn("prod_in_stock")
                product.prod_sale = rs.stringForColumn("prod_sale")
                product.prod_weight = rs.doubleForColumn("prod_weight")
                product.prod_width = rs.doubleForColumn("prod_width")
                product.prod_height = rs.doubleForColumn("prod_height")
                product.prod_depth = rs.doubleForColumn("prod_depth")
                product.prod_color = String(rs.stringForColumn("prod_color"))
                product.prod_gender = rs.stringForColumn("prod_gender")
                product.prod_bran_id = rs.intForColumn("prod_bran_id")
                product.prod_prc_id = rs.intForColumn("prod_prc_id")
                product.prod_rating = rs.intForColumn("prod_rating")
                product.prod_create_date = rs.dateForColumn("prod_create_date")
                product.prod_update_date = rs.dateForColumn("prod_update_date")
                product.prod_arrival_flag = rs.stringForColumn("prod_arrival_flag") == nil ? "":rs.stringForColumn("prod_arrival_flag")
                product.prod_imageArray = productImgController.getProductImageByProductId(product.prod_id)
                product.prod_bran = brandController.getBrandById(product.prod_bran_id)
                productArray.append(product)
            }
        } else {
                print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return productArray
    }
    
    func getProductByProductCategoryId(prc_Id: Int32) -> [ProductModel] {
        var productArray:[ProductModel] = []
        var product = ProductModel()
        let prodQuery = String(format: product.queryProductByProductCategoryId, prc_Id, "prod_name", "ASC")//String("SELECT * FROM PRODUCT where prod_id = \(prod_id) ORDER BY prod_name ASC")
        print(prodQuery)
        if let rs = database.executeQuery(prodQuery, withArgumentsInArray: nil) {
            while rs.next(){
                product = ProductModel()
                product.prod_id = rs.intForColumn("prod_id")
                product.prod_code = rs.stringForColumn("prod_code")
                product.prod_name = rs.stringForColumn("prod_name")
                //print("Product Name from Query : \(product.prod_name)")
                product.prod_type = rs.stringForColumn("prod_type")
                product.prod_price = rs.doubleForColumn("prod_price")
                product.prod_discount_price = rs.doubleForColumn("prod_discount_price")
                product.prod_description = rs.stringForColumn("prod_description")
                product.prod_details = rs.stringForColumn("prod_details")
                product.prod_remark = rs.stringForColumn("prod_remark") == nil ? "":rs.stringForColumn("prod_remark")
                product.prod_flight_only = rs.stringForColumn("prod_flight_only")
                product.prod_in_stock = rs.stringForColumn("prod_in_stock")
                product.prod_sale = rs.stringForColumn("prod_sale")
                product.prod_weight = rs.doubleForColumn("prod_weight")
                product.prod_width = rs.doubleForColumn("prod_width")
                product.prod_height = rs.doubleForColumn("prod_height")
                product.prod_depth = rs.doubleForColumn("prod_depth")
                product.prod_color = String(rs.stringForColumn("prod_color"))
                product.prod_gender = rs.stringForColumn("prod_gender")
                product.prod_bran_id = rs.intForColumn("prod_bran_id")
                product.prod_prc_id = rs.intForColumn("prod_prc_id")
                product.prod_rating = rs.intForColumn("prod_rating")
                product.prod_create_date = rs.dateForColumn("prod_create_date")
                product.prod_update_date = rs.dateForColumn("prod_update_date")
                product.prod_arrival_flag = rs.stringForColumn("prod_arrival_flag") == nil ? "":rs.stringForColumn("prod_arrival_flag")
                product.prod_imageArray = productImgController.getProductImageByProductId(product.prod_id)
                product.prod_bran = brandController.getBrandById(product.prod_bran_id)
                productArray.append(product)
            }
        } else {
                print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return productArray
        
    }

}