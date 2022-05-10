//
//  SendTokenTableViewController.swift
//  XDCPay
//
//  Created by Admin on 05/04/22.
//

var globaReceiverAddress = ""

import UIKit
import XDC3Swift

class SendTokenTableViewController: UITableViewController {
    
    let client =  XDCClientManager.shared.getXDCClient()
   
    var availableAmount = 0.0
    
    @IBOutlet weak var myAddressButton: UIButton!
    @IBOutlet weak var available: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var transactionNote: UITextField!
    @IBOutlet weak var gasLimit: UITextField!
    @IBOutlet weak var gasFees: UITextField!
    @IBOutlet weak var amountToBeSend: UITextField!
//    @IBOutlet weak var myAddress: UIButton!
    @IBOutlet weak var receiverAddress: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gasLimit.keyboardType = .numberPad
        self.gasFees.keyboardType = .numberPad
        self.amountToBeSend.keyboardType = .numberPad
        self.receiverAddress.text = globalRecieverAddress
        self.setupGasFees()
        self.setMyAddress()
        self.getBalance()
        self.receiverAddress.text = globaReceiverAddress
    }
    override func viewWillAppear(_ animated: Bool) {
      //  self.sendDemo()
    }
    
    func setupGasFees() {
        self.gasFees.text = "1"
        self.gasLimit.text = "21000"
    }
    
    func getMaxTransactionFees() ->Double {
        
       // let fee = self.gasLimit.text!.toDouble()
        
        return 0.0
    }
     
    func setMyAddress() {
        let str = UserDefaultsManager.shared.getCurrentAccoutWalletAddress()
        let index = str.index(str.startIndex, offsetBy: 12)
        let mySubstring1 = str[..<index]
        
        let index2 = str.index(str.endIndex, offsetBy: -4)
        let mySubstring2 = str[index2...] // playground
        
        let truncateStr = mySubstring1 + "..." + mySubstring2
        
        self.myAddressButton.setTitle("\(truncateStr)", for: .normal)
    }
    
    @IBAction func onMyAddress(_ sender: Any) {
       
    }
    
    @IBAction func onNext(_ sender: Any) {
        
        var amountTObeSend = 0.0
        
        if(!self.amountToBeSend.text!.isEmpty) {
            amountTObeSend = self.amountToBeSend.text?.toDouble() ?? 0.0
        }
        
        
        if(receiverAddress.text!.isEmpty) {
            showAlert(message: "Please Enter Recipient Address")
            return
        }
        
        if(amountTObeSend == 0) {
            showAlert(message: "Please Enter Correct Amount")
            return
        }
        
        
        if(amountTObeSend > availableAmount) {
            showAlert(message: "Balance not enough")
            return
        }
        
        if(gasLimit.text?.toDouble() ?? 0.0 < 21000) {
            showAlert(message: "Gas Limit must be greater than 2100 and less than 415800000")
            return
        }
        
        if(gasFees.text?.toDouble() ?? 0.0 < 1) {
            showAlert(message: "Gas price shoud be 1 or more")
            return
        }
        
       let vc =  self.storyboard?.instantiateViewController(identifier: "ConfirmSendVC" ) as! ConfirmSendVC
        vc.data = ["recipientAddress" : self.receiverAddress.text!, "amount" : self.amountToBeSend.text!, "gwei" : self.gasFees.text!, "gasLimit" : self.gasLimit.text! , "notes" : self.transactionNote.text!]
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
  
    @IBAction func onScan(_ sender: Any) {
        
        let scaner = ScannerViewController()
        self.present(scaner, animated: true, completion: nil)
        scaner.completionHandler = { qrCode in
        
            if(!qrCode.isEmpty) {
                self.receiverAddress.text = qrCode
            }
        
        }
        
        
    }
    
    
}


extension SendTokenTableViewController {
    
    func getBalance() {
        
        self.client.eth_getBalance(address: XDCAddress(UserDefaultsManager.shared.getMainWalletAddress()), block: .Latest) { (error, balanceOf) in
                
            if (balanceOf != nil){
                let value = balanceOf!/1000000000000000000
                print(value)
                self.availableAmount = Double(value)
              DispatchQueue.main.async {
                self.available.text =  "Available: \(value) XDC"
                 // self.getXdcPrice(xdcVal: value)
              }
            }
              
        }
    }
}

 

