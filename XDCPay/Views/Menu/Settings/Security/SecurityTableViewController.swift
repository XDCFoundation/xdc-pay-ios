//
//  SecurityTableViewController.swift
//  XDCPay
//
//  Created by Admin on 31/03/22.
//

import UIKit

class SecurityTableViewController: UITableViewController {

    @IBOutlet weak var biometricSwitch: UISwitch!
    var timerArray = ["Immediately", "5 seconds" , "15 seconds" , "30 seconds" , "60 seconds" , "5 minutes" , "10 minutes"]
    
    override func viewDidLoad() {
        
        self.tableView.tableFooterView = UIView()
        self.biometricSwitch.isOn = UserDefaultsManager.shared.faceIdEnabled
        self.biometricSwitch.addTarget(self, action: #selector(onSwitchValueChanged(_:)), for: .valueChanged)

    }
    
     @objc private func onSwitchValueChanged(_ switch: UISwitch) {
        
         if biometricSwitch.isOn == true {
             UserDefaultsManager.shared.faceIdEnabled = true
         }else if biometricSwitch.isOn == false {
             UserDefaultsManager.shared.faceIdEnabled = false
         }
    }
    
   
    @IBAction func onTime(_ sender: Any) {
        
        let pickerViewClass = self.storyboard?.instantiateViewController(withIdentifier: "PickerViewClass") as! PickerViewClass
                       pickerViewClass.pickerData = self.timerArray
        pickerViewClass.titleName = "Auto Lock Timer"
                            self.present(pickerViewClass, animated: true, completion: nil)
                           pickerViewClass.completionHandler = { selectedRow in
                              // self.positionButton.setTitle( self.positionArray[selectedRow], for: .normal)
                              // self.selectedIndex = selectedRow
                            
        }
        
    }
    
    @IBAction func onChangePassword(_ sender: Any) {
        securityViewController.presentVC(topTitleText: "Change Password")
    }
    
    @IBAction func onShowPrivateKey(_ sender: Any) {
        securityViewController.presentVC(topTitleText: "Show Private Key")
    }
    
    @IBAction func onReveal(_ sender: Any) {
        securityViewController.presentVC(topTitleText: "Secret seed words")
    }
}
