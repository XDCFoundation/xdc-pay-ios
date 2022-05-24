//
//  AddTokenViewController.swift
//  XDCPay
//
//  Created by Angshuman Das on 02/03/1401 AP.
//

import UIKit
import XDC3Swift

class AddTokenViewController: UIViewController {
    
    @IBOutlet weak var tokenAddress: UITextField!
    @IBOutlet weak var tokenSymbol: UITextField!
    @IBOutlet weak var tokenDecimal: UITextField!
    
    var tokenManager = TokenManager()
    var data = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
       
    }

    func setup() {
        tokenAddress.delegate = self
        tokenSymbol.isUserInteractionEnabled = false
        tokenDecimal.isUserInteractionEnabled = false
    }
    
    @IBAction func addTokenAction(_ sender: UIButton) {
        if (!data.isEmpty) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            DataBaseManager.shared.addTokens(data: data)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}


extension AddTokenViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let address = textField.text else {
            return
        }
        self.data.updateValue(address, forKey: "tokenAddress")
        if address.count > 40 {
            tokenManager._symbolXRC20(_contractAddress: address) { symbol in
                DispatchQueue.main.async { [self] in
                    self.tokenSymbol.text = symbol
                    self.data.updateValue(symbol!, forKey: "tokenSymbol")
                }
            } onError: { error in
                
            }

            tokenManager._decimalXRC20(_contractAddress: textField.text!) { decimal in
                DispatchQueue.main.async { [self] in
                    self.tokenDecimal.text = decimal
                    self.data.updateValue(decimal!, forKey: "tokenDecimal")
                }
            } onError: { error in
                
            }


        }

    }
    
}
