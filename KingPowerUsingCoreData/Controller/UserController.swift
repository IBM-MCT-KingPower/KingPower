//
//  UserController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation


class UserController {
    
    var database:FMDatabase!
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    
    func authentication(username: String, password: String) -> UserModel? {   //Need return userObj
        
        var user = UserModel()
        let query = String(format: user.queryGetUserByUsernamePassword, username, password)
        
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            while rs.next(){
                user = UserModel()
                user.user_id = rs.intForColumn("user_id")
                user.user_username = rs.stringForColumn("user_username")
                user.user_password = rs.stringForColumn("user_password")
                return user
                
            }
        }else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
        return nil
        
    }
    
}