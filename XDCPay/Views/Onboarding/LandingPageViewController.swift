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
    
    @IBAction func onHome(_ sender: Any) {
        
        self.pVC(viewConterlerId: "HomeViewController")
        
//
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let homeVC = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//
//        homeVC.modalPresentationStyle = .fullScreen
//
//        self.present(homeVC, animated: true, completion: nil)
//
//
////        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
////        let homeVC = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
////
////        let navigationController = UINavigationController(rootViewController: homeVC)
////        navigationController.modalPresentationStyle = .fullScreen
////
////        self.present(navigationController, animated: true, completion: nil)
        
    }
    @IBAction func onImport(_ sender: Any) {
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImportFromSeedViewController")
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
      
    
    }
    
    @IBAction func onCreate(_ sender: Any) {
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateNewWalletViewController") as! CreateNewWalletViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    

}
