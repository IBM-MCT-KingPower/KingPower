//
//  UserGroupPermissionModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/2/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class UserGroupPermissionModel{
    
    var ugpm_id       : Int32 = 0
    var ugpm_urgr_id    : Int32 = 0
    var ugpm_perm_id    : Int32 = 0
    var ugpm_create_date : NSDate = NSDate()
    var ugpm_update_date : NSDate = NSDate()
    
    var getMappingById : String = ""
    var getMappingByPermissionId : String = ""
    var getMappingByUserGroupId : String = "SELECT * FROM UGR_PER_MAP WHERE UGPM_URGR_ID = %@;"
    
}