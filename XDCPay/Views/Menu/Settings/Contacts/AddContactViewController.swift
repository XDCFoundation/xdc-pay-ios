//
//  AddContactViewController.swift
//  XDCPay
//
//  Created by Admin on 01/04/22.
 
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
        
        if(self.address.text!.isEmpty && self.address.text!.count < 43) {
            showAlert(message: "Please enter valid Address")
            return
        }
        else if (self.address.text!.count < 43){
            showAlert(message: "Address should have 43 characters")
            return
        }
        else if (self.address.text!.containsSpecialCharacter ==  false){
            showAlert(message: "Address should be in Hexadecimal format")
            return
        }
        
       else if(self.name.text!.isEmpty) {
            showAlert(message: "Please enter name")
            return
        }
        
       else if(self.name.text!.isEmpty) {
            showAlert(message: "Please enter name")
            return
        }
        
       else if(self.name.text!.containsSpecialCharacter) {
            showAlert(message: "Special Character not allowed")
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
        let scaner = ScannerViewController()
        self.present(scaner, animated: true, completion: nil)
        scaner.completionHandler = { qrCode in
            
            if(!qrCode.isEmpty) {
                globaReceiverAddress = qrCode
                
                DispatchQueue.main.async {
                    self.pVC(viewConterlerId: "SendTokenViewController")
                }
            }
        }
        
    }
    
    @IBAction func onCancel(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}


 
extension String {
   var containsSpecialCharacter: Bool {
      let regex = ".*[^A-Za-z0-9].*"
      let testString = NSPredicate(format:"SELF MATCHES %@", regex)
      return testString.evaluate(with: self)
   }
}
