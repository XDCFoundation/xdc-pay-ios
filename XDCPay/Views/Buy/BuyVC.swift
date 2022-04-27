//
//  BuyVC.swift
//  XDCPay
//
//  Created by Admin on 27/04/22.
//

import UIKit

class BuyVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onBuySimplex(_ sender: Any) {
        
        if let url = URL(string: "https://simplex.bringtotheblock.net/") {
            UIApplication.shared.open(url)
        }
        
    }
    
}
