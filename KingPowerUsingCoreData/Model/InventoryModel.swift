//
//  InventoryModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class InventoryModel{
    
    var invt_id       : Int32 = 0
    var invt_prod_id    : Int32 = 0
    var invt_ware_id    : Int32 = 0
    var invt_location   : String = ""
    var invt_avai_quantity : Int32 = 0
    var invt_create_date : NSDate = NSDate()
    var invt_update_date : NSDate = NSDate()
    
    var queryUpdateInventoryByProductIdAndWarehouseId : String = "UPDATE INVENTORY SET INVT_AVAI_QUANTITY = %@ WHERE INVT_PROD_ID = %@ AND INVT_WARE_ID = %@;"
    var queryInventoryByProductIdAndWarehouseId : String = "SELECT INVT_ID, INVT_PROD_ID, INVT_WARE_ID, INVT_LOCATION, INVT_AVAI_QUANTITY, INVT_CREATE_DATE, INVT_UPDATE_DATE FROM INVENTORY WHERE INVT_PROD_ID = %@ AND INVT_WARE_ID = %@;"
    
}