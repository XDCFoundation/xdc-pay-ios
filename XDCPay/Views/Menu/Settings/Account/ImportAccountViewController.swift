//
//  ImportAccountViewController.swift
//  XDCPay
//
//  Created by Admin on 04/04/22.
//

import UIKit
import XDC3Swift


class ImportAccountViewController: UIViewController {

    @IBOutlet weak var privateKey: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onImport(_ sender: Any) {
        
        self.LoadingStart()
         
        DataBaseManager.shared.importAccount(rowPrivateKey: self.privateKey.text!)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           
            self.LoadingStop()
        
            SceneDelegate.shared?.checkLogin()
            
        }
        
    }
    
}
