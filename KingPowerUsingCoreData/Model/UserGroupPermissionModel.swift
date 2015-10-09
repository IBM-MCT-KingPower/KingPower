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
    
    var getMappingById : String = "SELECT UGPM_ID, UGPM_USGR_ID, UGPM_PERM_ID, UGPM_CREATE_DATE, UGPM_UPDATE_DATE FROM UGR_PER_MAP WHERE UGPM_ID = %@;"
    var getMappingByPermissionId : String = "SELECT UGPM_ID, UGPM_USGR_ID, UGPM_PERM_ID, UGPM_CREATE_DATE, UGPM_UPDATE_DATE FROM UGR_PER_MAP WHERE UGPM_PERM_ID = %@;"
    var getMappingByUserGroupId : String = "SELECT UGPM_ID, UGPM_USGR_ID, UGPM_PERM_ID, UGPM_CREATE_DATE, UGPM_UPDATE_DATE FROM UGR_PER_MAP WHERE USGR_ID = %@;"

}