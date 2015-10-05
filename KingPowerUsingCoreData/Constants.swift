//
//  Constants.swift
//  InAppLocalize
//
//  Created by Dip Kasyap on 5/22/15.
//  Copyright (c) 2015 Dip Kasyap . All rights reserved.
// DIP: COPYLEFT : Feel Free to Customize & Improve :)



import UIKit
import DynamicColor

class Constants {
    
    //static let CURRENCY_CODE = "THB"
    
    func getLanguageCode()->NSString {
        
      // language code is saved as constant on #languaeManager class as DEFAULTS_KEY_LANGUAGE_CODE
         let languageCode = LanguageManager.sharedInstance.DEFAULTS_KEY_LANGUAGE_CODE
         print("The Selected Language code is  \(languageCode)")
         return languageCode
    }
    
    func customLocalizedString(key: NSString,comment: NSString)->NSString{
        return LanguageManager.sharedInstance.getTranslationForKey(key)

    }
    /*
    struct Color {
        static let LogoColor:UIColor =
        UIColor(hex: 0x6ECCB9)
        static let LinkColor:UIColor = UIColor(hex: 0x0081AF)
        static let GrayColor:UIColor = UIColor(hex: 0x4D4D4D)
        static let BorderColor:UIColor = UIColor(hex: 0xE5E5E5)
        static let WhiteColor:UIColor = UIColor(hex: 0xF5F5F5)
        static let RedColor:UIColor = UIColor(hex: 0xCA4200)
        static let GoldColor:UIColor = UIColor(hex: 0xF8AD05)
    }*/
}
