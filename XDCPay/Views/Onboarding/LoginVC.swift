//
//  LoginVC.swift
//  XDCPay
//
//  Created by Admin on 25/04/22.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var faceIdSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        let walletData = UserDefaults.standard.array(forKey: "WalletData") ?? []
        
        if let password =  walletData[2] as? String {
            
            if( password == self.password.text) {
                UserDefaults.standard.setValue(false, forKey: "logOut")
                SceneDelegate.shared?.checkLogin()
            }else {
                self.showAlert(message: "Password does not correct")
            }
            
        }
       
         
            
       
    }
    
    @IBAction func onCreateNewWallet(_ sender: Any) {
        
    }
    

    @IBAction func onRestore(_ sender: Any) {
        
    }
}
