//
//  LanguageManager.swift
//  InAppLocalize
//
//  Created by Dip Kasyap on 5/22/15.
//  Copyright (c) 2015 Dip Kasyap . All rights reserved.
// DIP: COPYLEFT : Feel Free to Customize & Improve :)
// DIP:: Singleton that manages the language selection and translations for strings in the app.




import UIKit

class LanguageManager: NSObject {
    
    var DEFAULTS_KEY_LANGUAGE_CODE:NSString = NSString()
    var availableLocales = [Locale]()
    var constant: Constants = Constants()

       override init() {
            
            // Manually create a list of available localisations for this example project.
        let english = Locale()
            english.initWithLanguageCode("en", countryCode: "gb", name: "United Kingdom")
        
        let thai  = Locale()
            thai.initWithLanguageCode("th", countryCode: "thai", name: "Thailand")
            self.availableLocales = [english,thai]
    }
    
    class var sharedInstance: LanguageManager {
        
        
        struct Static {
            static var instance: LanguageManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = LanguageManager()
        }
        
        return Static.instance!
    }
    
    
    
 
    func setLanguageWithLocale(locale: Locale) {
        
        print("\(locale.languageCode)")
        
        NSUserDefaults.standardUserDefaults().setObject(locale.languageCode, forKey: "DEFAULTS_KEY_LANGUAGE_CODE")
            }
    
   
    
    func getSelectedLocale()->Locale{
        var selectedLocale = Locale()
        //Get the Language code 
        let languageCode = NSUserDefaults.standardUserDefaults().stringForKey("DEFAULTS_KEY_LANGUAGE_CODE")?.lowercaseString
        for locale in availableLocales {
            if(locale.languageCode == languageCode){
                selectedLocale = locale
                break
                
            }
        }
        return selectedLocale
    }
    
    
    
    // DIP Return a translated string for the given string key.
    func getTranslationForKey(key: NSString)->NSString {
    
    // Get the language code.
        print("language code after is \(constant.getLanguageCode())")
        let languageCode =  NSUserDefaults.standardUserDefaults().stringForKey("DEFAULTS_KEY_LANGUAGE_CODE")
        
    // Get language bundle that is relevant.
        let bundlePath = NSBundle.mainBundle().pathForResource(languageCode as String?, ofType: "lproj")
        let Languagebundle = NSBundle(path: bundlePath!)
        
    // Get the translated string using the language bundle.
        let translatedString = Languagebundle?.localizedStringForKey(key as String, value:"", table: nil)
        return translatedString!;
    }
}