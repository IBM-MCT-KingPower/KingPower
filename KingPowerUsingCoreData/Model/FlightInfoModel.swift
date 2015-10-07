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
    
    var queryInsertFlight : String = ""
    var queryUpdateFlightById : String = ""
    var queryGetFlightByCustomerIdAndCurrentDate : String = ""
    
    
}