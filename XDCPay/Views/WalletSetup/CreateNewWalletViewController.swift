//
//  CreateNewWalletViewController.swift
//  XDCPay
//
//  Created by Chhaya Singh Parihar on 24/03/22.
//

import UIKit

class CreateNewWalletViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.backButtonTitle = " "
    }
   

}
