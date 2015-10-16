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
    
    func insertFlight(flii_cust_id: Int32, flii_airline: String, flii_flight_no: String, flii_flight_date: String, flii_return_flag: String, flii_create_date: String) -> FlightInfoModel? {
        
        var flightInfo = FlightInfoModel()
        let query = String(format: flightInfo.queryInsertFlight, flii_cust_id, flii_airline, flii_flight_no, flii_flight_date, flii_return_flag, flii_create_date)
        
        print("\nQUERY: \(query)")
        let updateSuccessful = database.executeUpdate(query, withArgumentsInArray: nil)
        if !updateSuccessful {
            print("update failed: \(database.lastErrorMessage())")
            
        }else{
            var maxId : Int32 = 0
            let queryGetMaxId = String(format: flightInfo.queryGetMaxId)
            if let rs = database.executeQuery(queryGetMaxId, withArgumentsInArray: nil){
                while rs.next() {
                    maxId = rs.intForColumn("max_col")
                    break;
                }
            }
            print("INSERT SUCCESS : ID: \(maxId)")
            
            //Get Data
            let queryGetData = "SELECT * FROM FLIGHT_INFO WHERE flii_id = \(maxId)"
            if let rs = database.executeQuery(queryGetData, withArgumentsInArray: nil){
                while rs.next(){
                    print(rs.stringForColumn("flii_flight_date"))
                    break
                }
                
            }
            
            
            return getFlightById(maxId)
            
        }
        return nil
        
    }
    
    func getFlightById(flii_id: Int32) -> FlightInfoModel? {
        var flightInfo = FlightInfoModel()
        let query = "SELECT FLII_ID, FLII_CUST_ID, FLII_AIRLINE, FLII_FLIGHT_NO, FLII_FLIGHT_DATE, FLII_RETURN_FLAG, FLII_CREATE_DATE FROM FLIGHT_INFO WHERE FLII_ID = \(flii_id)"
        //        let query = String(format: flightInfo.queryGetFlightById, flii_id)
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            while rs.next(){
                flightInfo.flii_id = rs.intForColumn("flii_id")
                flightInfo.flii_cust_id = rs.intForColumn("flii_cust_id")
                flightInfo.flii_airline = rs.stringForColumn("flii_airline")
                flightInfo.flii_flight_no = rs.stringForColumn("flii_flight_no")
                flightInfo.flii_flight_date = rs.dateForColumn("flii_flight_date")
                flightInfo.flii_return_flag = rs.stringForColumn("flii_return_flag")
                flightInfo.flii_create_date = rs.dateForColumn("flii_create_date")
                return flightInfo
            }
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
        }
        return nil
        
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