//
//  Double.swift
//  XDCPay
//
//  Created by Admin on 12/04/22.
//

import Foundation


 
extension Double {
    
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func roundTo4() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 4
        numberFormatter.locale =  Locale(identifier: "en_US")
        guard let number =  numberFormatter.string(from: NSNumber(value: self)) else { fatalError("Can not get number") }
        return number
    }
    
    func getXDCValue() -> String {
        
        let value = self
        
        if(value > 999 && value < 10000){
           return  "\(value.roundTo4()) XDC"
         }else{
             if (value >= 1000000 && value < 999999999) {
                                         let x  = (value / 1000000)
                                         return  "\(x)M XDC"
                                     }else if (value >= 10000 && value < 999999){
                                         let x  = (value / 1000).roundTo4()
                                        return  "\(x)K XDC"
                                     }else if ( value >= 1000000000000 && value < 9999999999999 ) {
                                         let x  = (value / 1000000000000)
                                        return "\(x)B XDC"
                                     }else {
                                        return "\(value) XDC"
                                     }
                                     
         }
        
    }
    
}
 
