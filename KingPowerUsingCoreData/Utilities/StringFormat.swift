//
//  StringFormat.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 9/21/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import Foundation
extension NSNumber {
    var currency: String {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.formatterBehavior = NSNumberFormatterBehavior.Behavior10_4
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        if let result = numberFormatter.stringFromNumber(self) {
            return result
        }
        return ""
    }

}

extension UIFont {
    var bold:UIFont {
        let fontDesc = fontDescriptor().fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold)
        return UIFont(descriptor: fontDesc, size: 0)

    }
}