//
//  TokenOptionVC.swift
//  XDCPay
//
//  Created by Angshuman Das on 04/03/1401 AP.
//

import UIKit

class TokenOptionVC: UIViewController {
    

    @IBOutlet weak var accountViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var view2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view2.clipsToBounds = true
        self.view2.layer.cornerRadius = 10
        self.view2.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    @IBAction func onSendAction(_ sender: Any) {
        
        
    }
    
    @IBAction func onViewTokenOnObservatory(_ sender: Any) {
        
        
        
    }
    
    @IBAction func copyAddressFromClipboard(_ sender: Any) {
        
        
        
    }
    
    @IBAction func removeBtnAction(_ sender: Any) {
        
        
        
    }
    
}
