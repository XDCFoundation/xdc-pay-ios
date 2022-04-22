

import UIKit
import XDC3Swift
import PSMeter


class ImportFromSeedViewController: UIViewController {
    
    @IBOutlet var newPassword: UITextField!
    @IBOutlet weak var psMeter: PSMeter!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var enableBio: UILabel!
    @IBOutlet var checkBox: UIButton!
    @IBOutlet var importWalletBtn: UIButton!
    @IBOutlet var understandText: UILabel!
    @IBOutlet weak var secretTextView: UITextView!
      
   
    
    var showSecret = false
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        importWalletBtn.layer.cornerRadius = 4
        secretTextView.text = ""
        
    }
    
    @IBAction func onShowPassword(_ sender: Any) {
        
        self.newPassword.isSecureTextEntry = false
        self.confirmPassword.isSecureTextEntry = false
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    @IBAction func passwordDidChange(_ sender: Any) {
        guard let password = newPassword.text else {
            return
        }
        psMeter.updateStrengthIndication(password: password)
    }
    
    @IBAction func checkBoxOnTap(_ sender: UIButton) {
     
     
        if(showSecret == false)
        {
            self.secretTextView.isSecureTextEntry = false
            sender.setBackgroundImage((UIImage(named: "CheckBoxSelected")), for: UIControl.State.normal)
            showSecret = true
        }
        
        else{
            self.secretTextView.isSecureTextEntry = true
          
            sender.setBackgroundImage((UIImage(named: "CheckBoxEmpty")), for: UIControl.State.normal)
            showSecret = false
        }
    }
     
    @IBAction func importWalletBtnAction(_ sender: UIButton) {
        
        if(newPassword.text! != confirmPassword!.text ) {
            showAlert(message: "Password does not match")
            return
        }
        
        if(newPassword.text!.count < 8) {
            showAlert(message: "Password length should be more then eight")
            return
        }
        
        if(psMeter.passwordStrength == PasswordStrength.weak || psMeter.passwordStrength == PasswordStrength.veryWeak ) {
   
            showAlert(message: "Password is \(psMeter.passwordStrength!)")
            return
            
        }
        
        if(secretTextView.text!.count < 24) {
   
            showAlert(message: "Please enter correct Secret Phrase")
            return
            
        }
        
        
        
        if newPassword.text == confirmPassword.text &&  self.secretTextView.text!.count >= 24   {
            
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
 
