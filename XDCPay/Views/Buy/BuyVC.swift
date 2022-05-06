//
//  BuyVC.swift
//  XDCPay
//
//  Created by Admin on 27/04/22

import UIKit

class BuyVC: UIViewController {

    @IBOutlet weak var simplexView: UIView!
    @IBOutlet weak var faucetView: UIView!
    
    @IBOutlet weak var faucetBtn: UIButton!
    
    var isMainNet = false
    var selectedNetwork:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedNetwork = UserDefaultsManager.shared.getCurrentNetworName()
        faucetBtn.setTitle("  \(selectedNetwork ?? "")", for: .normal)
        
        if(selectedNetwork == "XDC Mainnet") {
            self.simplexView.isHidden = false
            self.faucetView.isHidden = true
        }else {
            self.simplexView.isHidden = true
            self.faucetView.isHidden = false
        }
    }
    
    @IBAction func onBuySimplex(_ sender: Any) {
        
        let networks = DataBaseManager.shared.getNetworks()
        if let index = networks.firstIndex(where: { $0.name == selectedNetwork }) {
            let url = networks[index].url
            if let url = URL(string: "\(url)") {
                UIApplication.shared.open(url)
            }
        }
        
    }
    
    
    @IBAction func onFaucet(_ sender: Any) {
        
        let networks = DataBaseManager.shared.getNetworks()
        if let index = networks.firstIndex(where: { $0.name == selectedNetwork }) {
            let url = networks[index].url
            if let url = URL(string: "\(url)") {
                UIApplication.shared.open(url)
            }
        }
        
        
    }
    
}
