//
//  UIViewController.swift
//  XDCPay
//
//  Created by Admin on 08/04/22.
//

import UIKit

extension UIViewController {

    
    func showAlert(message:String,completion: ((_ success:Bool)->Void)?){
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (alert) in
            completion?(true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(message:String){
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (alert) in
            
           // completion?(true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func restartApp() {
        print("f")
        // get a reference to the app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // call didFinishLaunchWithOptions ... why?
        appDelegate.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    }
    
    
    func  closeAllAndMoveHome() { // main
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        
    }

}
