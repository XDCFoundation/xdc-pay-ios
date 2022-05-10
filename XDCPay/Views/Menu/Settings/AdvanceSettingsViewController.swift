//
//  AdvanceSettingsViewController.swift
//  XDCPay
//
//  Created by Admin on 30/03/22.
//

import UIKit

class AdvanceSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func DownloadStateLogsBtnAction(_ sender: UIButton) {
        MessageDisplayer.showMessage(message: "Under development")
    }
    
    @IBAction func resetAccountBtnAction(_ sender: UIButton) {
        
        let dialogMessage = UIAlertController(title: "Reset account", message: "Resetting your account will clear your transaction history.", preferredStyle: .alert)
         
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            UserDefaultsManager.shared.resetAccount()
            
            SceneDelegate.shared?.checkLogin()
            
        })
       
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
           
        }
        //Add OK and Cancel button to an Alert object
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        // Present alert message to user
        self.present(dialogMessage, animated: true, completion: nil)

    
    }
    

}
