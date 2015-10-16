//
//  GlobalVariable.swift
//  KingPowerUsingCoreData
//
//  Created by Patis Piriyahaphan on 9/19/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

struct GlobalVariable {
    var configurationPath = NSBundle.mainBundle().pathForResource("kp", ofType: "plist")
    
    var departAirlinePickerOption = ["ANA", "Cathay Pacific", "Emirates", "Qatar Airways", "Singapore Airlines", "Thai Airways"]
    var returnAirlinePickerOption = ["ANA", "Cathay Pacific", "Emirates", "Qatar Airways", "Singapore Airlines", "Thai Airways"]
    

    
    func getConfigValue(key: String) -> AnyObject{
        if let configuration = NSDictionary(contentsOfFile: self.configurationPath!){
//            return configuration["\(key)"] as! String
            return configuration["\(key)"]!
        }
        return ""
    }
    
    
    func getFlightNo(airline: String) -> [String]{
        
        switch airline {
            case "ANA": return ["NH245", "NH429", "NH504", "NH892", "NH0252", "NH0355", "NH1190", "NH3942", "NH5012", "NH8910"]
            case "Cathay Pacific": return ["CX2013", "CX3024", "CX3500", "CX6948", "CX6991", "CX8995", "CX9184", "CX9092"]
            case "Emirates": return ["EK203", "EK294", "EK440", "EK495", "EK568", "EK849", "EK850", "EK909", "EK1034"]
            case "Etihad Airways": return ["EY240", "EY304", "EY408", "EY409", "EY429", "EY536", "EY891", "EY941"]
            case "KLM": return ["KL004", "KL122", "KL590", "KL630", "KL731", "KL856", "KL0521", "KL0879", "KL4812"]
            case "Lufthansa": return ["LH048", "LH223", "LH497", "LH561", "LH812", "LH0294", "LH3023", "LH5209"]
            case "Qantas": return ["QF020", "QF045", "QF193", "QF302", "QF411", "QF580", "QF794", "QF830", "QF918"]
            case "Qatar Airways": return ["QR2039", "QR4020", "QR6221","QR7023", "QR7611", "QR9280", "QR9520"]
            case "Singapore Airlines": return ["SQ042", "SQ075", "SQ227", "SQ309", "SQ386", "SQ416", "SQ501", "SQ688"]
            case "Thai Airways": return ["TG0313", "TG0431", "TG0507", "TG0559", "TG0683", "TG0792", "TG0914", "TG0969"]
        default: return []
        }
        
    }
    
}