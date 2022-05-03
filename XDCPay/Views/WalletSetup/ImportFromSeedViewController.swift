

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
    @IBOutlet weak var showBtn: UIButton!
    var showSelected = true
    
    
    var showSecret = false
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        importWalletBtn.layer.cornerRadius = 4
        secretTextView.text = ""
        
    }
    
    @IBAction func onShowPassword(_ sender: Any) {
        
        if showSelected {
            self.newPassword.isSecureTextEntry = false
            self.confirmPassword.isSecureTextEntry = false
            self.showBtn.setTitle("Hide", for: .normal)
        } else {
            self.newPassword.isSecureTextEntry = true
            self.confirmPassword.isSecureTextEntry = true
            self.showBtn.setTitle("Show", for: .normal)
        }
        showSelected = !showSelected
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
            
            UserDefaultsManager.shared.clearUserDefaults()
            
            DataBaseManager.shared.addDefaultNetworks()
            
            
            DataBaseManager.shared.saveDefaultAccount(address: importFromMnemonic.address, privateKey: importFromMnemonic.rawPrivateKey, publicKey: importFromMnemonic.rawPublicKey)
            
            let accountData = [importFromMnemonic.address,importFromMnemonic.rawPrivateKey, newPassword.text! , importFromMnemonic.rawPublicKey ]
            
            UserDefaults.standard.setValue(accountData, forKey: "WalletData")
            UserDefaults.standard.setValue(mnemonic, forKey: "seed")
            
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
}

extension ImportFromSeedViewController : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyz ").inverted
        let components = text.components(separatedBy: allowedCharacters)
        let filtered = components.joined(separator: "")
        
        if text == filtered {
            return true
        } else {
            return false
        }
    }
}
