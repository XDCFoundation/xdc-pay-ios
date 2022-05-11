

import UIKit
import XDC3Swift
import PSMeter


class CreateNewWalletViewController: UIViewController {
    
    @IBOutlet var newPassword: UITextField!
    @IBOutlet weak var psMeter: PSMeter!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var enableBio: UILabel!
    @IBOutlet var checkBox: UIButton!
    @IBOutlet var createWalletBtn: UIButton!
    @IBOutlet var newSwitch: UISwitch!
    @IBOutlet var understandText: UILabel!
    @IBOutlet weak var showBtn: UIButton!
    var showSelected = true
    
    var flag1 = false
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        newSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        createWalletBtn.layer.cornerRadius = 4
      
        //enableBio.isHidden = true
       // newSwitch.isHidden = true
    }
    
    @IBAction func onBackButtonPress(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
      
        if(flag1 == false)
        {
            sender.setBackgroundImage((UIImage(named: "CheckBoxSelected")), for: UIControl.State.normal)
            flag1 = true
        }
        
        else{
            sender.setBackgroundImage((UIImage(named: "CheckBoxEmpty")), for: UIControl.State.normal)
            flag1 = false
        }
    }
    @IBAction func bckButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func createWalletBtnAction(_ sender: UIButton) {
        
        if(psMeter.passwordStrength == PasswordStrength.weak || psMeter.passwordStrength == PasswordStrength.veryWeak ) {
   
            showAlert(message: "Password is \(psMeter.passwordStrength!)")
            return
            
        }
        
        if(newPassword.text!.count < 8) {
            showAlert(message: "Password length should be more then eight")
            return
        }
        
        if(newPassword.text! != confirmPassword!.text ) {
            showAlert(message: "Password does not match")
            return
        }
        
        if !flag1 {
            showAlert(message: "Check XDC Pay cannot recover this password for me")
            return
        }
        
        if newPassword.text == confirmPassword.text && flag1 == true {
           
            let acc = try! XDCAccount.createAccountWithMemonic()
            let importFromMnemonic = try! XDCAccount.importAccountWithMnemonic(mnemonic: acc)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecureWallectVC") as! SecureWallectVC
            vc.seedPhrase = acc
            let accountData = [importFromMnemonic.address,importFromMnemonic.rawPrivateKey,newPassword.text! ,importFromMnemonic.rawPublicKey ]
             vc.accountData = accountData
          
            print(acc)
            vc.modalPresentationStyle = .fullScreen
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }

}

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "CheckBoxSelected")! as UIImage
    let uncheckedImage = UIImage(named: "CheckBoxEmpty")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
