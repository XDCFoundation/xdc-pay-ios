//
//  ContactDetailViewController.swift
//  XDCPay
//
//  Created by Admin on 01/04/22.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    @IBOutlet weak var noTransaction: UILabel!
    var contactName = ""
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var address: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contacts = DataBaseManager.shared.getContacts()
        let contact =  contacts.filter{$0.name == contactName}.first
        self.name.text = contact!.name
        self.address.text = contact!.address
    
    }
    

    @IBAction func onEdit(_ sender: Any) {
        
        self.pVC(viewConterlerId: "EditContactViewController") 
    }
    
    @IBAction func onCopy(_ sender: Any) {
          showCopyToast()
          UIPasteboard.general.string = self.address.text!
    }
    

}
