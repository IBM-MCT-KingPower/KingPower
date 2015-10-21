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
    var flii_flight_date : String = ""
    var flii_return_flag : String = ""
    var flii_create_date : String = ""
    
    var queryInsertFlight : String = "INSERT INTO FLIGHT_INFO (FLII_CUST_ID, FLII_AIRLINE, FLII_FLIGHT_NO, FLII_FLIGHT_DATE, FLII_RETURN_FLAG, FLII_CREATE_DATE) VALUES (%d, '%@', '%@', '%@', '%@', '%@');"
    
    var queryUpdateFlightById : String = "UPDATE FLIGHT_INFO SET FLII_CUST_ID = %@, FLII_AIRLINE = '%@', FLII_FLIGHT_NO = '%@', FLII_FLIGHT_DATE = %@, FLII_RETURN_FLAG = '%@' WHERE FLII_ID = %@;"
    
    var queryGetMaxId : String = "SELECT MAX(FLII_ID) as max_col FROM FLIGHT_INFO"
    
    var queryGetFlightById : String = "SELECT FLII_ID, FLII_CUST_ID, FLII_AIRLINE, FLII_FLIGHT_NO, FLII_FLIGHT_DATE, FLII_RETURN_FLAG, FLII_CREATE_DATE FROM FLIGHT_INFO WHERE FLII_ID = %@"
    
    var queryGetFlightByCustomerIdAndCurrentDate : String = "SELECT FLII_ID, FLII_CUST_ID, FLII_AIRLINE, FLII_FLIGHT_NO, FLII_FLIGHT_DATE, FLII_RETURN_FLAG, FLII_CREATE_DATE FROM FLIGHT_INFO WHERE FLII_CUST_ID = %d AND DATE(FLII_FLIGHT_DATE) >= CURRENT_DATE ORDER BY FLII_CREATE_DATE;"
    
    var queryGetFlightByCustomerId : String = "SELECT FLII_ID, FLII_CUST_ID, FLII_AIRLINE, FLII_FLIGHT_NO, FLII_FLIGHT_DATE, FLII_RETURN_FLAG, FLII_CREATE_DATE FROM FLIGHT_INFO WHERE FLII_CUST_ID = %d ORDER BY FLII_CREATE_DATE;"
    
    var queryGetFlightByAirlineFlightNoDate : String = "SELECT FLII_ID, FLII_CUST_ID, FLII_AIRLINE, FLII_FLIGHT_NO, FLII_FLIGHT_DATE, FLII_RETURN_FLAG, FLII_CREATE_DATE FROM FLIGHT_INFO WHERE FLII_CUST_ID = %d AND FLII_AIRLINE = '%@' AND FLII_FLIGHT_NO = '%@' AND DATE(FLII_FLIGHT_DATE) = '%@' AND FLII_RETURN_FLAG = '%@';"
}