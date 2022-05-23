//
//  EditContactViewController.swift
//  XDCPay
//
//  Created by Admin on 01/04/22.
//

import UIKit

class EditContactViewController: UIViewController {
    
    var addressText = ""
    var nameText = ""
    var id = ""
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text =  nameText
        self.address.text =  addressText
    }
     
    @IBAction func onCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onDelete(_ sender: Any) {
        showCopyToast("Deleted")
        DataBaseManager.shared.deleteContact(id:id)
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onUpdate(_ sender: Any) {
        
        
        if(self.address.text!.isEmpty) {
            showAlert(message: "Please enter valid Address")
            return
        }
        
        if(self.name.text!.isEmpty) {
            showAlert(message: "Please enter name")
            return
        }
        
        if(self.name.text!.containsSpecialCharacter) {
            showAlert(message: "Special Character not allowed")
            return
        }
        
        DataBaseManager.shared.updateContact(name: name.text!, address: address.text! , id:id)
        showCopyToast("Contact Updated")
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
}
