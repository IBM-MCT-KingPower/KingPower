//
//  FlightInfoController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class FlightInfoController{
    
    var database:FMDatabase!
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    func insertFlight(custId: Int32, airline: String, flightNo: String, flightDate: NSDate, flightReturnFlag: String, createDate: NSDate){
        var flightInfo = FlightInfoModel()
        let query = String(format: flightInfo.queryInsertFlight, custId, airline, flightNo, flightDate, flightReturnFlag, createDate)
        print("\nQUERY: \(query)")
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            
        }

    }
    
    func updateFlight(){ //Need return FlightObj
        
    }
    
    func getFlightByCustomerId(){ //Need return FlightObj
        
    }
    
}