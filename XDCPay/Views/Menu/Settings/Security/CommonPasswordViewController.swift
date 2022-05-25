//
//  CommonPasswordViewController.swift
//  XDCPay
//
//  Created by Admin on 31/03/22.
//

import UIKit

class CommonPasswordViewController: UIViewController {
    
    var topTitleText  = ""
    var viewController = UIViewController()
    
    @IBOutlet weak var topTitle: UILabel!
    
    @IBOutlet weak var textFieldTitleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var commonButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.topTitle.text  = topTitleText
        self.textField.isSecureTextEntry = true
    
        if(topTitleText == "Change Password") {
            self.textFieldTitleLabel.text = "Confirm your current password"
            self.commonButton.setTitle("Confirm", for: .normal)
        }
        
        if(topTitleText == "Secret seed words") {
            self.textFieldTitleLabel.text = "Enter Password to continue"
            self.commonButton.setTitle("Reveal", for: .normal)
        }
        
        if(topTitleText == "Show Private Key") {
            self.textFieldTitleLabel.text = "Enter Password to continue"
            self.commonButton.setTitle("Reveal", for: .normal)
        }
        
    }
    
    @IBAction func onButtonPress(_ sender: Any) {
       
      
        let password = UserDefaults.standard.array(forKey: "WalletData")![2]
       
        if(self.textField.text! == password as! String ) {
            
            switch topTitleText {
            case  "Secret seed words":
                  viewController = self.storyboard!.instantiateViewController(withIdentifier: "SeedWordsViewController")
              
            case  "Change Password":
                  viewController = self.storyboard!.instantiateViewController(withIdentifier: "ChangePasswordViewController")
              
            case  "Show Private Key":
                 viewController = self.storyboard!.instantiateViewController(withIdentifier: "PrivateKeyViewController")
              
            default:
                print("")
            }
            viewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(viewController, animated: true)
        }else {
            showAlert(message: "Password not correct")
        }
        
    }
    

}
