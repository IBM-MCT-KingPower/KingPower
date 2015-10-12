//
//  ProductModel.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 10/3/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import Foundation

class ProductModel {
    var prod_id:Int32 = 0
    var prod_code:String = ""
    var prod_name:String = ""
    var prod_type:String = ""
    var prod_price:Double = 0
    var prod_discount_price:Double = 0
    var prod_description:String = ""
    var prod_details:String = ""
    var prod_remark:String = ""
    var prod_flight_only:String = ""
    var prod_in_stock:String = ""
    var prod_sale:String = ""
    var prod_weight:Double = 0
    var prod_width:Double = 0
    var prod_height:Double = 0
    var prod_depth:Double = 0
    var prod_color:String = ""
    var prod_gender:String = ""
    var prod_bran_id:Int32 = 0
    var prod_prc_id:Int32 = 0
    var prod_rating:Int32 = 0
    var prod_arrival_flag = ""
    var prod_create_date:NSDate = NSDate()
    var prod_update_date:NSDate = NSDate()
    var prod_imageArray:[ProductImageModel] = []
    var prod_bran: BrandModel = BrandModel()
    
    var queryProductAll : String = "SELECT PROD_ID, PROD_CODE, PROD_NAME, PROD_TYPE, PROD_PRICE, PROD_DISCOUNT_PRICE, PROD_DESCRIPTION, PROD_DETAILS, PROD_REMARK, PROD_FLIGHT_ONLY, PROD_IN_STOCK, PROD_SALE, PROD_WEIGHT, PROD_WIDTH, PROD_HEIGHT, PROD_DEPTH, PROD_COLOR, PROD_GENDER, PROD_BRAN_ID, PROD_PRC_ID, PROD_RATING, PROD_ARRIVAL_FLAG, PROD_CREATE_DATE, PROD_UPDATE_DATE FROM PRODUCT ORDER BY %@ %@;"
    var queryProductById : String = "SELECT PROD_ID, PROD_CODE, PROD_NAME, PROD_TYPE, PROD_PRICE, PROD_DISCOUNT_PRICE, PROD_DESCRIPTION, PROD_DETAILS, PROD_REMARK, PROD_FLIGHT_ONLY, PROD_IN_STOCK, PROD_SALE, PROD_WEIGHT, PROD_WIDTH, PROD_HEIGHT, PROD_DEPTH, PROD_COLOR, PROD_GENDER, PROD_BRAN_ID, PROD_PRC_ID, PROD_RATING, PROD_ARRIVAL_FLAG,PROD_CREATE_DATE, PROD_UPDATE_DATE FROM PRODUCT WHERE PROD_ID = %@ ORDER BY %@ %@;"
    var queryProductByBrandId : String = "SELECT PROD_ID, PROD_CODE, PROD_NAME, PROD_TYPE, PROD_PRICE, PROD_DISCOUNT_PRICE, PROD_DESCRIPTION, PROD_DETAILS, PROD_REMARK, PROD_FLIGHT_ONLY, PROD_IN_STOCK, PROD_SALE, PROD_WEIGHT, PROD_WIDTH, PROD_HEIGHT, PROD_DEPTH, PROD_COLOR, PROD_GENDER, PROD_BRAN_ID, PROD_PRC_ID, PROD_RATING, PROD_ARRIVAL_FLAG,PROD_CREATE_DATE, PROD_UPDATE_DATE FROM PRODUCT WHERE PROD_BRAN_ID = %@ ORDER BY %@ %@;"
    var queryProductByProductCategoryId : String = "SELECT PROD_ID, PROD_CODE, PROD_NAME, PROD_TYPE, PROD_PRICE, PROD_DISCOUNT_PRICE, PROD_DESCRIPTION, PROD_DETAILS, PROD_REMARK, PROD_FLIGHT_ONLY, PROD_IN_STOCK, PROD_SALE, PROD_WEIGHT, PROD_WIDTH, PROD_HEIGHT, PROD_DEPTH, PROD_COLOR, PROD_GENDER, PROD_BRAN_ID, PROD_PRC_ID, PROD_RATING, PROD_ARRIVAL_FLAG, PROD_CREATE_DATE, PROD_UPDATE_DATE FROM PRODUCT WHERE PROD_PRC_ID = %@ ORDER BY %@ %@;"
    var queryProductByGender : String = "SELECT PROD_ID, PROD_CODE, PROD_NAME, PROD_TYPE, PROD_PRICE, PROD_DISCOUNT_PRICE, PROD_DESCRIPTION, PROD_DETAILS, PROD_REMARK, PROD_FLIGHT_ONLY, PROD_IN_STOCK, PROD_SALE, PROD_WEIGHT, PROD_WIDTH,  PROD_HEIGHT, PROD_DEPTH, PROD_COLOR, PROD_GENDER, PROD_BRAN_ID, PROD_PRC_ID, PROD_RATING, PROD_ARRIVAL_FLAG, PROD_CREATE_DATE, PROD_UPDATE_DATE FROM PRODUCT WHERE PROD_GENDER IN ('%@','UNISEX') ORDER BY %@ %@;"
    var queryProductByProductGroupId : String = "SELECT PROD_ID, PROD_CODE, PROD_NAME, PROD_TYPE, PROD_PRICE, PROD_DISCOUNT_PRICE, PROD_DESCRIPTION, PROD_DETAILS, PROD_REMARK, PROD_FLIGHT_ONLY, PROD_IN_STOCK, PROD_SALE, PROD_WEIGHT, PROD_WIDTH, PROD_HEIGHT, PROD_DEPTH, PROD_COLOR, PROD_GENDER, PROD_BRAN_ID, PROD_PRC_ID, PROD_RATING, PROD_ARRIVAL_FLAG, PROD_CREATE_DATE, PROD_UPDATE_DATE FROM PRODUCT JOIN PRODUCT_CATEGORY ON PROD_PRC_ID = PRC_ID JOIN PRODUCT_GROUP ON PRC_PROG_ID = PROG_ID WHERE PRC_PROG_ID = %d"//ORDER BY %@ %@;"
    
}