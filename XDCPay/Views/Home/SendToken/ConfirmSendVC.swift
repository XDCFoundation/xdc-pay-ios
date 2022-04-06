//
//  ConfirmSendVC.swift
//  XDCPay
//
//  Created by Admin on 06/04/22.
//

import UIKit

class ConfirmSendVC: UIViewController {
    
    
    @IBAction func onNext(_ sender: Any) {
        
        self.pVC(viewConterlerId: "TokenSentSuccessVC")
    }
    

}
