//
//  PasswordEstimator.swift
//  PasswordStrengthMeter
//
//  Created by Omar on 9/15/20.
//  Copyright © 2020 Baianat. All rights reserved.
//

import Foundation
import Navajo_Swift

public protocol PasswordEstimator {
    func estimatePassword(_ password: String) -> PasswordStrength
}

struct DefaultPasswordEstimator: PasswordEstimator {
    func estimatePassword(_ password: String) -> PasswordStrength {

        if password.isEmpty {
            return .empty
        } else {
            
            if (password.count < 8) {
                        return .weak
            }else if(password.count > 7 && password.isValidPassword())   {
                return .strong
            }
            else {
            let strength = Navajo.strength(ofPassword: password)
            switch strength {
            case .veryWeak:
                return .veryWeak
            case .weak:
                return .weak
            case .reasonable:
                return .fair
            case .strong:
                return .strong
            case .veryStrong:
                return .veryStrong
            }
        }
      }
    }

}


extension String {
    
    //At least 1 Uppercase, 1 Lowercase, 1 Special Characters, 1 Number, and Total 8 Characters or Long
    func isValidPassword() -> Bool {
        //let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[ !\"\\\\#$%&'()*+,-./:;<=>?@\\[\\]^_`{|}~])[A-Za-z\\d !\"\\\\#$%&'()*+,-./:;<=>?@\\[\\]^_`{|}~]{8,}"
        //safe to escape all regex chars
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[ !\"\\\\#$%&'\\(\\)\\*+,\\-\\./:;<=>?@\\[\\]^_`\\{|\\}~])[A-Za-z\\d !\"\\\\#$%&'\\(\\)\\*+,\\-\\./:;<=>?@\\[\\]^_`\\{|\\}~]{8,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}
