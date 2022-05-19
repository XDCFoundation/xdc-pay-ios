//
//  ContactDetailViewController.swift
//  XDCPay
//
//  Created by Admin on 01/04/22.
//

import UIKit

class ContactDetailViewController: UIViewController {

    var contactName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(contactName)
    }
    

    @IBAction func onEdit(_ sender: Any) {
        
        self.pVC(viewConterlerId: "EditContactViewController") 
    }
    

}
