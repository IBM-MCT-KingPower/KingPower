//
//  UserModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class UserModel{
    
    var user_id       : Int32 = 0
    var user_username    : String = ""
    var user_password    : String = ""
    var user_create_date : NSDate = NSDate()
    var user_update_date : NSDate = NSDate()
    
    var queryGetUserByUsernamePassword : String = "SELECT * FROM USER WHERE USER_USERNAME = %@ AND USER_PASSWORD = %@;"
    
}
