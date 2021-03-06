//
//  PrivateKeyViewController.swift
//  XDCPay
//
//  Created by Admin on 31/03/22.
//

import UIKit

class PrivateKeyViewController: UIViewController {

    
    @IBOutlet weak var privateKey: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let value = UserDefaults.standard.array(forKey: "WalletData")
        let privateKeyWallet = value![1] as! String
        self.privateKey.text = privateKeyWallet
         
    }
    
    @IBAction func onCopy(_ sender: Any) {
        self.showCopyToast()
        UIPasteboard.general.string =  self.privateKey.text!
    }
    
    @IBAction func bckButton(_ sender: Any) {
        if let navController = self.navigationController {
            for controller in navController.viewControllers {
                if controller is SecurityViewController { // Change to suit your menu view controller subclass
                    navController.popToViewController(controller, animated:true)
                    break
                }
            }
        }
    }
    

}
