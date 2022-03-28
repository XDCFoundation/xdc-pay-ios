//
//  UIView+Extention.swift
//  XDCPay
//
//  Created by Chhaya Singh Parihar on 22/03/22.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
           get {
               return layer.cornerRadius
           }
           set {
               layer.cornerRadius = newValue
               layer.masksToBounds = newValue > 0
           }
       }

       @IBInspectable var borderWidth: CGFloat {
           get {
               return layer.borderWidth
           }
           set {
               layer.borderWidth = newValue
           }
       }

    @IBInspectable var borderColor: UIColor? {
            set {
                layer.borderColor = newValue?.cgColor
            }
            get {
                guard let color = layer.borderColor else {
                    return nil
                }
                return UIColor(cgColor: color)
            }
    }
    
}
