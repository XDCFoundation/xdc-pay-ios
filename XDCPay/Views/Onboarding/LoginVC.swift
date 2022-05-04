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
                self.showAlert(message: "The Password you entered is incorrect. Please try again.")
            }
            
        }
       
    }
    
    @IBAction func onCreateNewWallet(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateNewWalletViewController") as! CreateNewWalletViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    

    @IBAction func onRestore(_ sender: Any) {
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImportFromSeedViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
