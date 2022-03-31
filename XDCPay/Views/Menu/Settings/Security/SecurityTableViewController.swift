//
//  SecurityTableViewController.swift
//  XDCPay
//
//  Created by Admin on 31/03/22.
//

import UIKit

class SecurityTableViewController: UITableViewController {

    var timerArray = ["Immediately", "5 seconds" , "15 seconds" , "30 seconds" , "60 seconds" , "5 minutes" , "10 minutes"]
    
    override func viewDidLoad() {
        
        self.tableView.tableFooterView = UIView()
        
    }
    
   
    
   
    @IBAction func onTime(_ sender: Any) {
        
        let pickerViewClass = self.storyboard?.instantiateViewController(withIdentifier: "PickerViewClass") as! PickerViewClass
                       pickerViewClass.pickerData = self.timerArray
        pickerViewClass.titleName = "Auto Lock Timer"
                            self.present(pickerViewClass, animated: true, completion: nil)
                           pickerViewClass.completionHandler = { selectedRow in
                              // self.positionButton.setTitle( self.positionArray[selectedRow], for: .normal)
                              // self.selectedIndex = selectedRow
                               return  0
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
