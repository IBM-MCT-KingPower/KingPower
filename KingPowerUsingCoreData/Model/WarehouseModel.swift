//
//  WarehouseModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/2/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class WarehouseModel{
    
    var ware_id       : Int32 = 0
    var ware_name    : String = ""
    var ware_address    : String = ""
    
    var queryGetWarehouseById : String = "SELECT WARE_ID, WARE_NAME, WARE_ADDRESS FROM WAREHOUSE WHERE WARE_ID = %@;"
    var queryGetWarehouseAll : String = "SELECT WARE_ID, WARE_NAME, WARE_ADDRESS FROM WAREHOUSE;"
    
}