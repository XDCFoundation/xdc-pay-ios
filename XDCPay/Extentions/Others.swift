//
//  Others.swift
//  XDCPay
//
//  Created by Admin on 30/03/22.
//

import UIKit


extension UIViewController {
    
    
    func pVC(viewConterlerId : String)     {
        
        let vc = UIStoryboard(name: "Storyboard2", bundle: nil).instantiateViewController(withIdentifier: viewConterlerId)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
}


