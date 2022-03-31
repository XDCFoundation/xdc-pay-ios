//
//  LandingPageViewController.swift
//  XDCPay
//
//  Created by Chhaya Singh Parihar on 24/03/22.
//

import UIKit

class LandingPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBAction func importFromSeedAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ImportFromSeedViewController") as! ImportFromSeedViewController
         navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func createNewWalletAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateNewWalletViewController") as! CreateNewWalletViewController
         navigationController?.pushViewController(vc, animated: true)
    }

}
