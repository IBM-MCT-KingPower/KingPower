//
//  UserGroupMapModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class UserGroupMapModel{
    
    var usgm_id       : Int32 = 0
    var usgm_user_id    : Int32 = 0
    var usgm_usgr_id    : Int32 = 0
    var usgm_create_date : NSDate = NSDate()
    var usgm_update_date : NSDate = NSDate()
    
    var queryGetMappingById : String = "SELECT USGM_ID, USGM_USER_ID, USGM_USGR_ID USGM_CREATE_DATE, USGM_UPDATE_DATE FROM USER_GROUP_MAP WHERE USGM_ID = %@;"
    var queryGetMappingByUserGroupId : String = "SELECT USGM_ID, USGM_USER_ID, USGM_USGR_ID USGM_CREATE_DATE, USGM_UPDATE_DATE FROM USER_GROUP_MAP WHERE USGM_USGR_ID = %@;"
    var queryGetMappingByUserId : String = "SELECT USGM_ID, USGM_USER_ID, USGM_USGR_ID USGM_CREATE_DATE, USGM_UPDATE_DATE FROM USER_GROUP_MAP WHERE USGM_USER_ID = %@;"

    
}