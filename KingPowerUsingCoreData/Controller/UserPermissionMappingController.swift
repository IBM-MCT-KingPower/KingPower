//
//  UserPermissionMappingController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class UserPermissionMappingController {
    
    var database:FMDatabase!
    var userGroupPermissionArray: [UserGroupPermissionModel] = []
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func getPermissionByUserGroupId(userGroupId: Int) -> [UserGroupPermissionModel] { //Need return list of UserPermissionMapping
        var userGroupPermission = UserGroupPermissionModel()
        let query = String(format: userGroupPermission.getMappingByUserGroupId, String(userGroupId))
        
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            while rs.next(){
                userGroupPermission = UserGroupPermissionModel()
                userGroupPermission.ugpm_id = rs.intForColumn("ugpm_id")
                userGroupPermission.ugpm_urgr_id = rs.intForColumn("ugpm_urgr_id")
                userGroupPermission.ugpm_perm_id = rs.intForColumn("ugpm_perm_id")
                self.userGroupPermissionArray.append(userGroupPermission)
            }
        }else {
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            
        }
        return self.userGroupPermissionArray
    }
    
}
