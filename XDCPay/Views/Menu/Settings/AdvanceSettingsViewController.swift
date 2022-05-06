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
        MessageDisplayer.showMessage(message: "Under development")
    }
    

}
