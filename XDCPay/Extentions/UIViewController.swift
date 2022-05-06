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

    func showToast(message : String, font: UIFont, view:UIView) {

//        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        let toastLabel = UILabel(frame: CGRect(x: view.frame.origin.x + view.frame.size.width + 10, y: view.frame.origin.y, width: 80, height: 24))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 6;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    

}
