//
//  TokenCell.swift
//  XDCPay
//
//  Created by Admin on 29/03/22.
//

import UIKit


class TokenCell: UITableViewCell {

    @IBOutlet weak var tokenImg: UIImageView!
    @IBOutlet weak var tokenDetails: UILabel!
    
    @IBAction func tokenOptions(_ sender: UIButton) {
       // homeVc.pVC(viewConterlerId: "TokenOptionVC")
        
        let pickerViewClass = homeVc.storyboard?.instantiateViewController(withIdentifier: "TokenOptionVC") as! TokenOptionVC
        homeVc.present(pickerViewClass, animated: true, completion: nil)
    }
    
}
