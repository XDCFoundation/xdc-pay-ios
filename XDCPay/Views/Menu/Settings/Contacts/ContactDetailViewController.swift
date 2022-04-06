//
//  ContactDetailViewController.swift
//  XDCPay
//
//  Created by Admin on 01/04/22.
//

import UIKit

class ContactDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onEdit(_ sender: Any) {
        
        self.pVC(viewConterlerId: "EditContactViewController") 
    }
    

}
