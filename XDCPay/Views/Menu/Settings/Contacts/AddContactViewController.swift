//
//  AddContactViewController.swift
//  XDCPay
//
//  Created by Admin on 01/04/22.
//

import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var address: UITextField!
    var titleText = ""
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topTitle.text = titleText
    }
    
    @IBAction func onAdd(_ sender: Any) {
        
        if(self.address.text!.isEmpty) {
            showAlert(message: "Please enter valid Address")
            return
        }
        
        if(self.name.text!.isEmpty) {
            showAlert(message: "Please enter name")
            return
        }
        
        let contacts = DataBaseManager.shared.getContacts().map{$0.name}
        let addresses = DataBaseManager.shared.getContacts().map{$0.address}
        
        if (contacts.contains(self.name.text!)) {
            showAlert(message: "Please use diffrent Name, This name is already Used!")
            return
        }
        
        if (addresses.contains(self.address.text!)) {
            showAlert(message: "This Contact Address is already exist")
            return
        }
        
        DataBaseManager.shared.addContact(name: name.text!, address: address.text!)
        showCopyToast("Contact Added")
        self.navigationController?.popViewController(animated: true)
        
    }
    
  
    
    @IBAction func onScan(_ sender: Any) {
        
        
    }
    
    @IBAction func onCancel(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
