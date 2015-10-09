//
//  UserGroupModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class UserGroupModel{
    
    var usgr_id       : Int32 = 0
    var usgr_name    : String = ""
    var usgr_create_date : NSDate = NSDate()
    var usgr_update_date : NSDate = NSDate()
    
    var queryGetUserGroupAll : String = "SELECT USGR_ID, USGR_NAME, USGR_CREATE_DATE, USGR_UPDATE_DATE FROM USER_GROUP;"
    var queryGetUserGroupById : String = "SELECT USGR_ID, USGR_NAME, USGR_CREATE_DATE, USGR_UPDATE_DATE FROM USER_GROUP WHERE USGR_ID = %@;"
    
}
