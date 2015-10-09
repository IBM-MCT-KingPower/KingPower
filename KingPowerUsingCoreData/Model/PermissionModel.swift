//
//  PermissionModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class PermissionModel{
    
    var perm_id       : Int32 = 0
    var perm_name    : String = ""
    var perm_create_date : NSDate = NSDate()
    var perm_update_date : NSDate = NSDate()
    
    var queryGetPermissionById : String = "SELECT PERM_ID, PERM_NAME, PERM_CREATE_DATE, PERM_UPDATE_DATE FROM PERMISSION WHERE PERM_ID = %@;"
    
}