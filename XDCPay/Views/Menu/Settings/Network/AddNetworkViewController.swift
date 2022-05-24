//
//  AddNetworkViewController.swift
//  XDCPay
//
//  Created by Admin on 30/03/22.
//

import UIKit

class AddNetworkViewController: UIViewController {

    @IBOutlet weak var networkTextField: UITextField!
    @IBOutlet weak var addNetworkButton: UIButton!
    @IBOutlet weak var rpcTextField: UITextField!
    @IBOutlet weak var chainIDTextField: UITextField!
    @IBOutlet weak var currencySymbolTextField: UITextField!
    @IBOutlet weak var blockTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chainIDTextField.keyboardType = .numberPad

    }
    
    @IBAction func onAddNetwork(_ sender: Any) {
        
        if(self.networkTextField.text!.isEmpty) {
            self.showAlert(message: "Please Enter Network Name")
            return
        }
        
        if(self.rpcTextField.text!.isEmpty) {
            self.showAlert(message: "Please Enter Rpc Url")
            return
        }
        
        if(!self.rpcTextField.text!.isValidateURL()) {
            self.showAlert(message: "Please Enter correct Url")
            return
        }
        
        if(self.chainIDTextField.text!.isEmpty) {
            self.showAlert(message: "Please Enter Chain Id")
            return
        }
        
     
        if(!blockTextField.text!.isEmpty && !self.blockTextField.text!.isValidateURL()) {
            self.showAlert(message: "Please Enter correct Block Url")
            return
        }
        
        let db = DataBaseManager.shared.getNetworks().filter{$0.name == self.networkTextField.text!}
        
        if(db.count > 0) {
            self.showAlert(message: "This Network Name is already used, Please use diffrent name")
            return
        }
         
        var netwrokFound = false
        
        for netwrok in DataBaseManager.shared.getNetworks() {
         
            if(netwrok.name.lowercased() == self.networkTextField.text!.lowercased()) {
                netwrokFound = true
                break
            }
        }
       
        if(netwrokFound) {
            showAlert(message: "Network Name Already Used, Please use diffrent Name")
            return
        }
        
        
        DataBaseManager.shared.addNetwork(name: self.networkTextField.text!, rpc: self.rpcTextField.text!, id: self.chainIDTextField.text!, symbol: self.currencySymbolTextField.text!, url: self.blockTextField.text ?? "", isEditable: "Yes")
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

}

