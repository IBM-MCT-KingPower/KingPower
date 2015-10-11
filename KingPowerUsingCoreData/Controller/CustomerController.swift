//
//  CustomerController.swift
//  KingPowerUsingCoreData
//
//  Created by Pannray Samanphanchai on 10/3/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation

class CustomerController{
    
    var database:FMDatabase!
    
    init(){
        self.database = DatabaseUtil().getDBConnect()
    }
    
    
    func getCustomerByMemberId(memberId: String) -> CustomerModel? { //Need return customerObj
        var customer = CustomerModel()
        let query = String(format: customer.queryGetCustomerByMemberId, memberId)
        print("\nQUERY: \(query)")
        if let rs = database.executeQuery(query, withArgumentsInArray: nil){
            while rs.next() {
                customer = CustomerModel()
                customer.cust_id = rs.intForColumn("cust_id")
                customer.cust_title = rs.stringForColumn("cust_title")
                customer.cust_first_name = rs.stringForColumn("cust_first_name")
                customer.cust_last_name = rs.stringForColumn("cust_last_name")
                customer.cust_member_id = rs.stringForColumn("cust_member_id")
                customer.cust_gender = rs.stringForColumn("cust_gender")
                customer.cust_card_id = rs.intForColumn("cust_card_id")
                customer.cust_card_exp_date = rs.dateForColumn("cust_card_exp_date")
                customer.cust_point = rs.intForColumn("cust_point")
                customer.cust_point_exp_date = rs.dateForColumn("cust_point_exp_date")
                customer.cust_create_date = rs.dateForColumn("cust_create_date")
                customer.cust_update_date = rs.dateForColumn("cust_update_date")
                
                return customer
            }
            
        }else{
            print("select failed: \(database.lastErrorMessage())", terminator: "")
            return nil
        }
        
        return nil
    }
    
}
