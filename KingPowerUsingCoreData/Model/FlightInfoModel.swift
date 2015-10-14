//
//  FlightInfoModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class FlightInfoModel{
    
    var flii_id         : Int32 = 0
    var flii_cust_id    : Int32 = 0
    var flii_airline : String = ""
    var flii_flight_no  : String = ""
    var flii_flight_date : NSDate = NSDate()
    var flii_return_flag : String = ""
    var flii_create_date : NSDate = NSDate()
    
    var queryInsertFlight : String = "INSERT INTO FLIGHT_INFO (FLII_CUST_ID, FLII_AIRLINE, FLII_FLIGHT_NO, FLII_FLIGHT_DATE, FLII_RETURN_FLAG, FLII_CREATE_DATE) VALUES (%@, '%@', '%@', '%@', '%@', '%@');"
    
    var queryUpdateFlightById : String = "UPDATE FLIGHT_INFO SET FLII_CUST_ID = %@, FLII_AIRLINE = '%@', FLII_FLIGHT_NO = '%@', FLII_FLIGHT_DATE = %@, FLII_RETURN_FLAG = '%@' WHERE FLII_ID = %@;"
    
    var queryGetMaxId : String = "SELECT MAX(FLII_ID) as max_col FROM FLIGHT_INFO"
    
    var queryGetFlightById : String = "SELECT FLII_ID, FLII_CUST_ID, FLII_AIRLINE, FLII_FLIGHT_NO, FLII_FLIGHT_DATE, FLII_RETURN_FLAG, FLII_CREATE_DATE FROM FLIGHT_INFO WHERE FLII_ID = %@"
    
    var queryGetFlightByCustomerIdAndCurrentDate : String = "SELECT FLII_ID, FLII_CUST_ID, FLII_AIRLINE, FLII_FLIGHT_NO, FLII_FLIGHT_DATE, FLII_RETURN_FLAG, FLII_CREATE_DATE FROM FLIGHT_INFO WHERE FLII_CUST_ID = %@ AND FLII_CREATE_DATE-CURRENT_TIMESTAMP <= 1;"
    
    
}