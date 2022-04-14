//
//  TokenSentSuccessVC.swift
//  XDCPay
//
//  Created by Admin on 06/04/22.
//

import UIKit

class TokenSentSuccessVC: UIViewController {

    @IBOutlet weak var hashOrAddress: UILabel!
    
    var data = [String:String]()
    
    override func viewDidLoad() {
        self.hashOrAddress.text = data["hash"]
    }

    @IBAction func onCopy(_ sender: Any) {
        UIPasteboard.general.string =  self.hashOrAddress.text!
    }
    
    @IBAction func onVewTransaction(_ sender: Any) {
       
        if let url = URL(string: "https://explorer.apothem.network/txs/\(self.hashOrAddress.text!)") {
            UIApplication.shared.open(url)
        }
        
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        self.closeAllAndMoveHome()
    }
    
    
}
