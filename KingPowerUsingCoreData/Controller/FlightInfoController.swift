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
    
    func insertFlight(flii_cust_id: Int32, flii_airline: String, flii_flight_no: String, flii_flight_date: NSDate, flii_return_flag: String, flii_create_date: NSDate){
        
        var flightInfo = FlightInfoModel()
        let query = String(format: flightInfo.queryInsertFlight, flii_cust_id, flii_airline, flii_flight_no, flii_flight_date, flii_return_flag, flii_create_date)
        print("\nQUERY: \(query)")
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            print("CREATE FLIGHT SUCCESSFULLY")
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            
        }

    }
    
    func updateFlight(flii_id: Int32, flii_cust_id: Int32, flii_airline: String, flii_flight_no: String, flii_flight_date: NSDate, flii_return_flag: String, flii_create_date: NSDate){
        
        var flightInfo = FlightInfoModel()
        let query = String(format: flightInfo.queryUpdateFlightById, flii_cust_id, flii_airline, flii_flight_no, flii_flight_date, flii_return_flag, flii_id)
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            print("UPDATE FLIGHT SUCCESSFULLY")
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            
        }
        
    }
    
    func getFlightByCustomerId(flii_cust_id: Int32) -> [FlightInfoModel]?{ //Need return FlightObj
        var flightInfo = FlightInfoModel()
        let query = String(format: flightInfo.queryGetFlightByCustomerIdAndCurrentDate, flii_cust_id)
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            
            var flightArray : [FlightInfoModel] = []
            while(rs.next()){
                var flightObj : FlightInfoModel = FlightInfoModel()
                flightObj.flii_id = rs.intForColumn("flii_id")
                flightObj.flii_cust_id = rs.intForColumn("flii_cust_id")
                flightObj.flii_airline = rs.stringForColumn("flii_airline")
                flightObj.flii_flight_no = rs.stringForColumn("flii_flight_no")
                flightObj.flii_flight_date = rs.dateForColumn("flii_flight_date")
                flightObj.flii_return_flag = rs.stringForColumn("flii_return_flag")
                flightObj.flii_create_date = rs.dateForColumn("flii_create_date")
                
                flightArray.append(flightObj)
            }
            return flightArray
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
        return nil
        
    }
    
}