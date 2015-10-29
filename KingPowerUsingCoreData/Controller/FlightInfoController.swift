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
    func insertFlight(flii_cust_id: Int32, flii_airline: String, flii_flight_no: String, flii_flight_date: String, flii_return_flag: String) -> Int32? {
        
        //let existFlightInfo = self.checkFlightByAirlineFlightNoDate(flii_cust_id, airline: flii_airline, flightNo: flii_flight_no, flightDate: flii_flight_date, returnFlag: flii_return_flag)
        
        //if existFlightInfo?.flii_id == 0 {
            var flightInfo = FlightInfoModel()
            let query = String(format: flightInfo.queryInsertFlight, flii_cust_id, flii_airline, flii_flight_no, flii_flight_date, flii_return_flag)
        
            print("\nQUERY: \(query)")
            let updateSuccessful = database.executeUpdate(query, withArgumentsInArray: nil)
            if !updateSuccessful {
            print("update failed: \(database.lastErrorMessage())")
            
            }else{
//                var maxId : Int32 = 0
//                let queryGetMaxId = String(format: flightInfo.queryGetMaxId)
//                if let rs = database.executeQuery(queryGetMaxId, withArgumentsInArray: nil){
//                    while rs.next() {
//                        maxId = rs.intForColumn("max_col")
//                        break;
//                    }
//                }
//                print("INSERT SUCCESS : ID: \(maxId)")
//            
//                //Get Data
//                let queryGetData = "SELECT * FROM FLIGHT_INFO WHERE flii_id = \(maxId)"
//                if let rs = database.executeQuery(queryGetData, withArgumentsInArray: nil){
//                    while rs.next(){
//                        print(rs.stringForColumn("flii_flight_date"))
//                        break
//                    }
//                
//                }
                
                return Int32(database.lastInsertRowId())
            
            }
        //}
        //return existFlightInfo
        return nil
    }
    
    func getFlightById(flii_id: Int32) -> FlightInfoModel? {
        var flightInfo = FlightInfoModel()
        let query = String(format: flightInfo.queryGetFlightById, flii_id)
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            while rs.next(){
                flightInfo.flii_id = rs.intForColumn("flii_id")
                flightInfo.flii_cust_id = rs.intForColumn("flii_cust_id")
                flightInfo.flii_airline = rs.stringForColumn("flii_airline")
                flightInfo.flii_flight_no = rs.stringForColumn("flii_flight_no")
                flightInfo.flii_flight_date = rs.stringForColumn("flii_flight_date")
                flightInfo.flii_return_flag = rs.stringForColumn("flii_return_flag")
                flightInfo.flii_create_date = rs.stringForColumn("flii_create_date")
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
                flightInfo = FlightInfoModel()
                flightInfo.flii_id = rs.intForColumn("flii_id")
                flightInfo.flii_cust_id = rs.intForColumn("flii_cust_id")
                flightInfo.flii_airline = rs.stringForColumn("flii_airline")
                flightInfo.flii_flight_no = rs.stringForColumn("flii_flight_no")
                flightInfo.flii_flight_date = rs.stringForColumn("flii_flight_date")
                flightInfo.flii_return_flag = rs.stringForColumn("flii_return_flag")
                flightInfo.flii_create_date = rs.stringForColumn("flii_create_date")
                
                flightArray.append(flightInfo)
            }
            return flightArray
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
        return nil
        
    }
    
    func getFlightByCustomerIdOnly(flii_cust_id: Int32) -> [FlightInfoModel]?{ //Need return FlightObj
        var flightInfo = FlightInfoModel()
        let query = String(format: flightInfo.queryGetFlightByCustomerIdAndCurrentDate, flii_cust_id)
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            
            var flightArray : [FlightInfoModel] = []
            while(rs.next()){
                flightInfo = FlightInfoModel()
                flightInfo.flii_id = rs.intForColumn("flii_id")
                flightInfo.flii_cust_id = rs.intForColumn("flii_cust_id")
                flightInfo.flii_airline = rs.stringForColumn("flii_airline")
                flightInfo.flii_flight_no = rs.stringForColumn("flii_flight_no")
                flightInfo.flii_flight_date = rs.stringForColumn("flii_flight_date")
                flightInfo.flii_return_flag = rs.stringForColumn("flii_return_flag")
                flightInfo.flii_create_date = rs.stringForColumn("flii_create_date")
                
                flightArray.append(flightInfo)
            }
            return flightArray
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
        
    }

    
    func checkFlightByAirlineFlightNoDate(custId:Int32, airline:String, flightNo:String, flightDate:String, returnFlag:String) -> FlightInfoModel?{ //Need return FlightObj
        var flightInfo = FlightInfoModel()
        //let query = "SELECT FLII_ID, FLII_CUST_ID, FLII_AIRLINE, FLII_FLIGHT_NO, FLII_FLIGHT_DATE, FLII_RETURN_FLAG, FLII_CREATE_DATE WHERE FLII_CUST_ID = \(custId) AND FLII_AIRLINE = '\(airline)' AND FLII_FLIGHT_NO = '\(flightNo)' AND DATE(FLII_FLIGHT_DATE) = \(flightDate) AND FLII_RETURN_FLAG = '\(returnFlag)';"
        let query = String(format: flightInfo.queryGetFlightByAirlineFlightNoDate, custId, airline, flightNo, flightDate, returnFlag)
        print("\nQUERY: \(query)")
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            while(rs.next()){
                flightInfo = FlightInfoModel()
                flightInfo.flii_id = rs.intForColumn("flii_id")
                flightInfo.flii_cust_id = rs.intForColumn("flii_cust_id")
                flightInfo.flii_airline = rs.stringForColumn("flii_airline")
                flightInfo.flii_flight_no = rs.stringForColumn("flii_flight_no")
                flightInfo.flii_flight_date = rs.stringForColumn("flii_flight_date")
                flightInfo.flii_return_flag = rs.stringForColumn("flii_return_flag")
                flightInfo.flii_create_date = rs.stringForColumn("flii_create_date")
                break
            }
            print("Flght Info \(flightInfo.flii_id)")
            return flightInfo
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
        
    }
    
}