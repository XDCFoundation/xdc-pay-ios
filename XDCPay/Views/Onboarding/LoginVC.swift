//
//  LoginVC.swift
//  XDCPay
//
//  Created by Admin on 25/04/22.
//

import UIKit
import LocalAuthentication

class LoginVC: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var faceIdSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        
        if(password.text!.isEmpty) {
            showAlert(message: "Please enter password")
            return
        }
        if faceIdSwitch.isOn == true &&  UserDefaultsManager.shared.faceIdEnabled == true {
            authenticationWithFaceID()
        } else if faceIdSwitch.isOn == false {
            let walletData = UserDefaults.standard.array(forKey: "WalletData") ?? []
            if let password =  walletData[2] as? String {
                if( password == self.password.text) {
                    UserDefaults.standard.setValue(false, forKey: "logOut")
                    SceneDelegate.shared?.checkLogin()
                }else {
                    showAlert(message: "Password does not match")
                }
                
            }
        }else if faceIdSwitch.isOn == true && UserDefaultsManager.shared.faceIdEnabled == false {
            print("FACE ID PERMISSION DENIED. PLEASE USE PASSWORD")
        }
        
       
    }
    
    @IBAction func onCreateNewWallet(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateNewWalletViewController") as! CreateNewWalletViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func onRestore(_ sender: Any) {
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImportFromSeedViewController")
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true) 
    }
    
    func authenticationWithFaceID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"

        var authorizationError: NSError? = nil
        let reason = "Authentication required to access the secure data"

        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authorizationError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluateError in
                
                if success {
                    DispatchQueue.main.async() {
                        UserDefaults.standard.setValue(false, forKey: "logOut")
                        SceneDelegate.shared?.checkLogin()
                    }
                    
                } else {
                    // Failed to authenticate
                    guard let error = evaluateError else {
                        return
                    }
                    print(error)
                
                }
            }
        } else {
            
            guard let error = authorizationError else {
                return
            }
            print(error)
        }
    }

    
}
