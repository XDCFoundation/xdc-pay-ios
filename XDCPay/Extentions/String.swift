//
//  String.swift
//  XDCPay
//
//  Created by Admin on 12/04/22.
//

import Foundation
import UIKit


extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func isValidateURL() -> Bool {
            let regex = "http[s]?://(([^/:.[:space:]]+(.[^/:.[:space:]]+)*)|([0-9](.[0-9]{3})))(:[0-9]+)?((/[^?#[:space:]]+)([^#[:space:]]+)?(#.+)?)?"
            let test = NSPredicate(format:"SELF MATCHES %@", regex)
            let result = test.evaluate(with: self)
            return result
     }
    
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
    
    func chopPrefix(_ count: Int = 1) -> String {
            if count >= 0 && count <= self.count {
                let indexStartOfText = self.index(self.startIndex, offsetBy: count)
                return String(self[indexStartOfText...])
            }
            return ""
     }

     func chopSuffix(_ count: Int = 1) -> String {
            if count >= 0 && count <= self.count {
                let indexEndOfText = self.index(self.endIndex, offsetBy: -count)
                return String(self[..<indexEndOfText])
            }
            return ""
        }
    
    mutating func getTransactionAddress() -> String {
        
        if(self.prefix(3).lowercased() == "xdc") {
            
            self = self.chopPrefix(3)
            
            return "0x" + self 
            
        }
        else {
            return self
        }
    }
    
}


extension Double {

    func toString(decimal: Int = 9) -> String {
        let value = decimal < 0 ? 0 : decimal
        var string = String(format: "%.\(value)f", self)

        while string.last == "0" || string.last == "." {
            if string.last == "." { string = String(string.dropLast()); break}
            string = String(string.dropLast())
        }
        return string
    }
}

