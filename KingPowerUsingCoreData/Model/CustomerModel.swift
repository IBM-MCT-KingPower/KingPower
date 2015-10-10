//
//  CustomerModel.swift
//  KingPowerModel
//
//  Created by Warunee Phattharakijwanich on 10/1/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

public class CustomerModel{
    
    var cust_id         : Int32 = 0
    var cust_title      : String = ""
    var cust_first_name : String = ""
    var cust_last_name  : String = ""
    var cust_gender : String = ""
    var cust_member_id  : String = ""
    var cust_card_id    : Int32 = 0
    var cust_card_exp_date : NSDate = NSDate()
    var cust_point      : Int32 = 0
    var cust_point_exp_date : NSDate = NSDate()
    var cust_create_date : NSDate = NSDate()
    var cust_update_date : NSDate = NSDate()
    
    var queryGetCustomerByMemberId : String = "SELECT CUST_ID, CUST_FIRST_NAME, CUST_LAST_NAME, CUST_MEMBER_ID, CUST_CARD_ID, CUST_CARD_EXP_DATE, CUST_POINT, CUST_POINT_EXP_DATE, CUST_CREATE_DATE, CUST_UPDATE_DATE FROM CUSTOMER WHERE CUST_MEMBER_ID = %@;"
    
}