//
//  BackButton.swift
//  Auto Accounting
//
//  Created by HSM3 on 20/09/17.
//  Copyright © 2017 HandySolver. All rights reserved.
//
import UIKit



class MenuButton : UIButton {
   
    override func awakeFromNib() {
        
        self.addTarget(self, action:#selector(handleRegister), for: .touchUpInside)

    }
    
    @objc  func handleRegister(sender: UIButton){
        flipTransition(with: self.imageView!, view2:  self.imageView!)
        
         menuDrawer.showHideDrawer()
    }
    
}
