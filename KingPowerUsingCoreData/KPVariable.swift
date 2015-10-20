//
//  KPVariable.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 10/13/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation
struct KPVariable {
    
    
    static var sortDataArray = ["PRODUCT NAME A-Z","PRODUCT NAME Z-A","BRAND NAME A-Z","BRAND NAME Z-A","PRICE LOW-HIGH","PRICE HIGH-LOW","NEW ARRIVAL","MOST POPULAR","DISCOUNT"]
    static var genderList = ["Men", "Women", "Unisex"]
    static var priceRangeList = ["< 2,000 THB", "2,000 - 5,000 THB", "5,000 - 10,000 THB", "10,000 - 15,000 THB", "15000 - 20000 THB", "> 20,000 THB"]
    static var colorList = ["N/A", "White", "Brown", "Pink", "Purple", "Orange", "Green", "Silver", "Yellow", "Red", "Black", "Gold", "Blue", "Gray"]
    
    static var airlinePickerOption = ["ANA", "Cathay Pacific", "Emirates", "Etihad Airways", "Japan Airline", "KLM", "Lufthansa", "Qantas", "Qatar Airways", "Singapore Airlines", "Thai Airways"]
    
    static func getFlightNoByAirline(airline: String) -> [String]{
        
        switch airline {
        case "ANA": return ["NH245", "NH429", "NH504", "NH892", "NH0252", "NH0355", "NH1190", "NH3942", "NH5012", "NH8910"]
        case "Cathay Pacific": return ["CX2013", "CX3024", "CX3500", "CX6948", "CX6991", "CX8995", "CX9184", "CX9092"]
        case "Emirates": return ["EK203", "EK294", "EK440", "EK495", "EK568", "EK849", "EK850", "EK909", "EK1034"]
        case "Etihad Airways": return ["EY240", "EY304", "EY408", "EY409", "EY429", "EY536", "EY891", "EY941"]
        case "Japan Airline": return ["JL012", "JL308", "JL455", "JL731", "JL853", "JL946", "JL1039", "JL1040"]
        case "KLM": return ["KL004", "KL122", "KL590", "KL630", "KL731", "KL856", "KL0521", "KL0879", "KL4812"]
        case "Lufthansa": return ["LH048", "LH223", "LH497", "LH561", "LH812", "LH0294", "LH3023", "LH5209"]
        case "Qantas": return ["QF020", "QF045", "QF193", "QF302", "QF411", "QF580", "QF794", "QF830", "QF918"]
        case "Qatar Airways": return ["QR2039", "QR4020", "QR6221","QR7023", "QR7611", "QR9280", "QR9520"]
        case "Singapore Airlines": return ["SQ042", "SQ075", "SQ227", "SQ309", "SQ386", "SQ416", "SQ501", "SQ688"]
        case "Thai Airways": return ["TG0313", "TG0431", "TG0507", "TG0559", "TG0683", "TG0792", "TG0914", "TG0969"]
            
        default: return []
            
        }
        
    }
    
    var amountInCart : Int = 0
    
    func addAmountInCart(b: Int) -> Int {
        var totalAmount = b + self.amountInCart
        return totalAmount
        
    }
    
    func getAmountInCart() -> Int{
        return self.amountInCart
    }
    
}






