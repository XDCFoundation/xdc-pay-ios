

import UIKit
import XDC3Swift
import PSMeter


class ChangePasswordViewController: UIViewController {
    
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
        if let navController = self.navigationController {
            for controller in navController.viewControllers {
                if controller is SecurityViewController { // Change to suit your menu view controller subclass
                    navController.popToViewController(controller, animated:true)
                    break
                }
            }
        }
    }
    
    @IBAction func onResetPassword(_ sender: UIButton) {
        
        if(newPassword.text! != confirmPassword!.text ) {
            showAlert(message: "Password does not match")
            return
        }
      
        
        if(psMeter.passwordStrength == PasswordStrength.weak || psMeter.passwordStrength == PasswordStrength.veryWeak ) {
   
            showAlert(message: "Password is \(psMeter.passwordStrength!)")
            return
            
        }
        
        if(newPassword.text!.count < 8) {
            showAlert(message: "Password length should be more then eight")
            return
        }
        
        if !flag1 {
            showAlert(message: "Check XDC Pay cannot recover this password for me")
            return
        }
        
        if newPassword.text == confirmPassword.text && flag1 == true {
           
            
            var walletData = UserDefaults.standard.array(forKey: "WalletData")
            
            walletData![2] = self.newPassword.text!
            
            UserDefaults.standard.setValue(walletData, forKey: "WalletData")
           
            UserDefaults.standard.setValue(true, forKey: "logOut")
            
            showCopyToast("Password Chaged")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                SceneDelegate.shared?.checkLogin()
            }
            
           
           
            
        }
    }

}

 
