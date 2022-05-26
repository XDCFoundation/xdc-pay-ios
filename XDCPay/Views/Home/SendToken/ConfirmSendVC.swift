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
        self.total.text = Double(data["amount"]!.toDouble()! + temp).getXDCValue()
    }
    
    
    @IBAction func onNext(_ sender: Any) {
        self.sendAmount(to: self.toAddress.text!.getTransactionAddress(), amount: self.amount.text!.toDouble() ?? 0)
       
    }
   
    
    
    func sendAmount(to:String, amount:Double) {
        
        let value = UserDefaults.standard.array(forKey: "WalletData")
        let privateKeyWallet = value![1] as! String
        let privateKeyWithHexPrefix = privateKeyWallet.xdc3.withHexPrefix
        let xdcAccount = try? XDCAccount(keyStorage: XDCPrivateKeyStore(privateKey: privateKeyWithHexPrefix))
    
        let fee = self.fees.text!
        let totalAmount = self.total.text!
        let address = myAddress.text!
        
        self.client.eth_gasPrice { error, gasPrice in
             
            print(gasPrice ?? 0)
            
           // let chainId = DataBaseManager.shared.getNetworks().first?.id ?? "0"
            
            let chainId = DataBaseManager.shared.getNetworks().filter{$0.name == UserDefaultsManager.shared.getCurrentNetworName()}.first!.id
               
            
            let transcation = XDCTransaction(from: nil, to: XDCAddress(to), value: BigUInt(amount*1000000000000000000), data: nil, nonce: 3, gasPrice: BigUInt(gasPrice!), gasLimit: BigUInt(50005), chainId: Int(chainId))
          
            self.client.eth_sendRawTransaction(transcation, withAccount: xdcAccount!) { [self] error, hash in
    
                if let hash = hash {
                    
                    self.data.updateValue(hash, forKey: "hash")
                    self.data.updateValue(fee, forKey: "fee")
                    self.data.updateValue(totalAmount, forKey: "total")
                    self.data.updateValue(address, forKey: "myAddress")
                   
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
