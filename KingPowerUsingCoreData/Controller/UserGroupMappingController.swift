//
//  UserGroupMappingController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation


class UserGroupMappingController{
    
    var database:FMDatabase!
    var userGroupMapArray: [UserGroupMapModel] = []
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getUserGroupByUserId(userId: Int) -> [UserGroupMapModel] { //Need return list of UserGroupMapping
        var userGroupMap = UserGroupMapModel()
        let query = String(format: userGroupMap.queryGetMappingByUserId, String(userId))
        
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            while rs.next(){
                userGroupMap = UserGroupMapModel()
                userGroupMap.usgm_id = rs.intForColumn("usgm_id")
                userGroupMap.usgm_user_id = rs.intForColumn("usgm_user_id")
                userGroupMap.usgm_usgr_id = rs.intForColumn("usgm_usgr_id")
                self.userGroupMapArray.append(userGroupMap)
            }
        }else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            
        }
        return self.userGroupMapArray
    }
    
}