//
//  OrderDetailModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class OrderDetailModel{
    
    var ordd_id         : Int32 = 0
    var ordd_ordm_id    : Int32 = 0
    var ordd_prod_id    : Int32 = 0
    var ordd_quantity   : Int32 = 0
    var ordd_total_price    : Double = 0
    var ordd_redeem_item    : String = ""
    var ordd_pickup_now : String = ""
    var ordd_create_date : String = ""
    var ordd_update_date : String = ""
    var product = ProductModel()
    
    
    var queryInsertOrderDetail : String = "INSERT INTO ORDER_DETAIL (ORDD_ORDM_ID, ORDD_PROD_ID, ORDD_QUANTITY, ORDD_TOTAL_PRICE, ORDD_REDEEM_ITEM, ORDD_PICKUP_NOW, ORDD_CREATE_DATE, ORDD_UPDATE_DATE) VALUES (%d, %d, %d, %f, '%@', '%@', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);"
    
    var queryGetOrderDetailByOrderId : String = "SELECT ORDD_ID, ORDD_ORDM_ID, ORDD_PROD_ID, ORDD_QUANTITY, ORDD_TOTAL_PRICE, ORDD_REDEEM_ITEM, ORDD_PICKUP_NOW, ORDD_CREATE_DATE, ORDD_UPDATE_DATE FROM ORDER_DETAIL WHERE ORDD_ORDM_ID = %d;"
    
    var queryGetOrderDetailPickTypeByOrderId : String = "SELECT ORDD_ID, ORDD_ORDM_ID, ORDD_PROD_ID, ORDD_QUANTITY, ORDD_TOTAL_PRICE, ORDD_REDEEM_ITEM, ORDD_PICKUP_NOW, strftime('%%d/%%m/%%Y %%H:%%M:%%S', ORDD_CREATE_DATE) ORDD_CREATE_DATE, strftime('%%d/%%m/%%Y %%H:%%M:%%S', ORDD_UPDATE_DATE) ORDD_UPDATE_DATE FROM ORDER_DETAIL WHERE ORDD_ORDM_ID = %d AND ORDD_PICKUP_NOW = '%@';"
    
}