//
//  DatabaseUtil.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 10/3/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import Foundation

class DatabaseUtil {
    var database:FMDatabase!
    
    func getDBConnect()->FMDatabase{
        let documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let path = documentsFolder.stringByAppendingPathComponent("kp")
        
        let fileManager = NSFileManager()
        if (!fileManager.fileExistsAtPath(path)){
            
            let dbFilePath = NSBundle.mainBundle().pathForResource("kp", ofType: "sqlite")
            print(dbFilePath, terminator: "")
            do {
                try fileManager.copyItemAtPath(dbFilePath!, toPath: path)
            } catch _ {
            }
            
        }
        self.database = FMDatabase(path: path)
        
        if !self.database.open() {
            print("Unable to open database", terminator: "")
            
        }else{
            print("database is opened", terminator: "")
        }
        return self.database
    }

}