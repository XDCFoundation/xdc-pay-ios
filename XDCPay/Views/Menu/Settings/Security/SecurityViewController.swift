//
//  SecurityViewController.swift
//  XDCPay
//
//  Created by Admin on 31/03/22.
//

import UIKit

var securityViewController : SecurityViewController!

class SecurityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        securityViewController = self
      
    }
    
    func presentVC(topTitleText:String) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommonPasswordViewController") as! CommonPasswordViewController
        vc.topTitleText = topTitleText
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
 

}
