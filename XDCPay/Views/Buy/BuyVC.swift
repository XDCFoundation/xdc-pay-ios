//
//  BuyVC.swift
//  XDCPay
//
//  Created by Admin on 27/04/22

import UIKit

class BuyVC: UIViewController {

    @IBOutlet weak var simplexView: UIView!
    @IBOutlet weak var faucetView: UIView!
    
    var isMainNet = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(isMainNet) {
            self.simplexView.isHidden = false
            self.faucetView.isHidden = true
        }else {
            self.simplexView.isHidden = true
            self.faucetView.isHidden = false
        }
    }
    
    @IBAction func onBuySimplex(_ sender: Any) {
        
        if let url = URL(string: "https://simplex.bringtotheblock.net/") {
            UIApplication.shared.open(url)
        }
        
    }
    
    
    @IBAction func onFaucet(_ sender: Any) {
        
        if let url = URL(string: "http://faucet.apothem.network/") {
            UIApplication.shared.open(url)
        }
        
    }
    
}
