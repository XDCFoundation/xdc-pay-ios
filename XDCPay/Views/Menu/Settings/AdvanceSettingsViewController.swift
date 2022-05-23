//
//  AdvanceSettingsViewController.swift
//  XDCPay
//
//  Created by Admin on 30/03/22.
//

import UIKit

class AdvanceSettingsViewController: UIViewController {

    @IBOutlet weak var swith: UISwitch!
    @IBOutlet weak var onOffLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        swith.isUserInteractionEnabled = true
        swith.isOn = UserDefaultsManager.shared.getGas()
       
         
        if(swith.isOn) {
            self.onOffLabel.text = "On"
        }else {
            self.onOffLabel.text = "Off"
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSwith(_ sender: Any) {
        
        if(swith.isOn) {
            self.onOffLabel.text = "On"
            UserDefaultsManager.shared.setGas(status:"on")
        }else {
            self.onOffLabel.text = "Off"
            UserDefaultsManager.shared.setGas(status:"off")
        }
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
