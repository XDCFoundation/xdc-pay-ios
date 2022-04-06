//
//  SendTokenTableViewController.swift
//  XDCPay
//
//  Created by Admin on 05/04/22.
//

import UIKit

class SendTokenTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onNext(_ sender: Any) {
        
        self.pVC(viewConterlerId: "ConfirmSendVC")
    }
    
  

}
