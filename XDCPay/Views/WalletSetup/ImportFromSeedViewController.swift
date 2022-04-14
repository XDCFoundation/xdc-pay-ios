//
//  ImportFromSeedViewController.swift
//  XDCPay
//
//  Created by Chhaya Singh Parihar on 24/03/22.
//

import UIKit
import XDC3Swift

class ImportFromSeedViewController: UIViewController {
    
    @IBOutlet weak var secretTextView: UITextView!
    
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onImport(_ sender: Any) {
        
        if(newPassword.text!.isEmpty ) {
            self.showAlert(message: "Password enter password", completion: nil)
                return
        }
        else if(newPassword.text! != confirmPassword.text!) {
            self.showAlert(message: "Password does not match", completion: nil)
                return
        }else if(secretTextView.text.isEmpty) {
            self.showAlert(message: "Please enter Secret Phrase", completion: nil)
                return
        }else {
         
            
            let mnemonic = secretTextView!.text
            let importFromMnemonic = try! XDCAccount.importAccountWithMnemonic(mnemonic: mnemonic!)
            print(importFromMnemonic.address)
            
            let vc = UIStoryboard(name: "Storyboard2", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            vc.modalPresentationStyle = .fullScreen
            vc.accountAddress = importFromMnemonic.address
            vc.privateKey = importFromMnemonic.rawPrivateKey
            
            let accountData = [importFromMnemonic.address,importFromMnemonic.rawPrivateKey, newPassword.text!]
            
            UserDefaults.standard.setValue(accountData, forKey: "WalletData")
            
            self.present(vc, animated: true, completion: nil)
            
        }
       
         
    }
    
   

}
