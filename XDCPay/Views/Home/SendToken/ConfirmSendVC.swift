//
//  ConfirmSendVC.swift
//  XDCPay
//
//  Created by Admin on 06/04/22.
//

import UIKit
import XDC3Swift
import BigInt

class ConfirmSendVC: UIViewController {
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var fees: UILabel!
    @IBOutlet weak var gwei: UILabel!
    @IBOutlet weak var gasLimit: UILabel!
    @IBOutlet weak var myAddress: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var toAddress: UILabel!
    let client = XDCClientManager.shared.getXDCClient()
    var data = [String:String]()
    
    override func viewDidLoad() {
         
        self.myAddress.text = UserDefaultsManager.shared.getCurrentAccoutWalletAddress()
        self.gwei.text = data["gwei"]
        self.toAddress.text = data["recipientAddress"]
        self.amount.text = data["amount"]
        self.gasLimit.text = data["gasLimit"]
        self.setFees()
        
    }
    
    func setFees() {
        
        let temp = (self.gasLimit.text!.toDouble()! * gwei.text!.toDouble()!)    / 1000000000
        self.fees.text = temp.toString() + " XDC"
        self.total.text = String(data["amount"]!.toDouble()! + temp) + " XDC"
    }
    
    
    @IBAction func onNext(_ sender: Any) {
        self.sendAmount(to: self.toAddress.text!.getTransactionAddress(), amount: self.amount.text!.toDouble() ?? 0)
       
    }
   
    
    
    func sendAmount(to:String, amount:Double) {
       
        print(to)
        let value = UserDefaults.standard.array(forKey: "WalletData")
        let privateKeyWallet = value![1] as! String
        let privateKeyWithHexPrefix = privateKeyWallet.xdc3.withHexPrefix
        let xdcAccount = try? XDCAccount(keyStorage: XDCPrivateKeyStore(privateKey: privateKeyWithHexPrefix))
    
        self.client.eth_gasPrice { error, gasPrice in
             
            print(gasPrice ?? 0)
            
            let chainId = DataBaseManager.shared.getNetworks().first?.id ?? "0"
            
            let transcation = XDCTransaction(from: nil, to: XDCAddress(to), value: BigUInt(amount*1000000000000000000), data: nil, nonce: 3, gasPrice: BigUInt(gasPrice!), gasLimit: BigUInt(50005), chainId: Int(chainId))
          
            self.client.eth_sendRawTransaction(transcation, withAccount: xdcAccount!) { [self] error, hash in
                print(hash)
                if let hash = hash {
                    
                    self.data.updateValue(hash, forKey: "hash")
                    self.data.updateValue(self.fees.text!, forKey: "fee")
                    self.data.updateValue(self.total.text!, forKey: "total")
                    self.data.updateValue(self.myAddress.text!, forKey: "myAddress")
                   
                    DataBaseManager.shared.addTransaction(data:data)
                    
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(identifier: "TokenSentSuccessVC") as! TokenSentSuccessVC
                        vc.data = self.data
                        tempData = self.data
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion:nil)
                    }
                }else {
                    
                    DispatchQueue.main.async {
                        self.showAlert(message: "Transaction Error")
                    }
                    
                  
                }
               
              
            }
        }
    }

    @IBAction func onReset(_ sender: Any) {
        
    }
    
}
