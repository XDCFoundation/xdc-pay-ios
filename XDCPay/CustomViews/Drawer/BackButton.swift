//
//  BackButton.swift
//  Auto Accounting
//
//  Created by HSM3 on 20/09/17.
//  Copyright © 2017 HandySolver. All rights reserved.
//
import UIKit

class BackButton : UIButton {
    
    
    override func awakeFromNib() {
        
        self.addTarget(self, action:#selector(handleRegister), for: .touchUpInside)

    }
    
    @objc func handleRegister(sender: UIButton){
        
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
        topController.dismiss(animated: true, completion: nil)
        }
        
    }
    
}

class BackButtonNavigation : UIButton {
    
    
    override func awakeFromNib() {
        
        self.addTarget(self, action:#selector(handleRegister), for: .touchUpInside)

    }
    
    @objc func handleRegister(sender: UIButton){
        
        
     
        UIApplication.topViewController()?.navigationController?.popViewController(animated: true)
    }
    
}


extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        return viewController
    }
    
    class func topNavigationController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UINavigationController? {
        
        if let nav = viewController as? UINavigationController {
            return nav
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return selected.navigationController
            }
        }
        return viewController?.navigationController
    }
}


 
