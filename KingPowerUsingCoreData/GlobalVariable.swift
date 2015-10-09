//
//  GlobalVariable.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/19/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

struct GlobalVariable {
    var configurationPath = NSBundle.mainBundle().pathForResource("kp", ofType: "plist")
    
    func getConfigValue(key: String) -> AnyObject{
        if let configuration = NSDictionary(contentsOfFile: self.configurationPath!){
//            return configuration["\(key)"] as! String
            return configuration["\(key)"]!
        }
        return ""
    }
}