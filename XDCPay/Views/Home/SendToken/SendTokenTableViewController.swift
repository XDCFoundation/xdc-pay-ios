//
//  SendTokenTableViewController.swift
//  XDCPay
//
//  Created by Admin on 05/04/22.
//

import UIKit
import XDC3Swift

class SendTokenTableViewController: UITableViewController {
    
    let client = XDCClient(url: URL(string: testConfig.xinfinNetworkUrl)!)
    let AlamoObject = AlamoWebServices()
    var availableAmount = 0.0
    
    @IBOutlet weak var myAddressButton: UIButton!
    @IBOutlet weak var available: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var transactionNote: UITextField!
    @IBOutlet weak var gasLimit: UITextField!
    @IBOutlet weak var gasFees: UITextField!
    @IBOutlet weak var amountToBeSend: UITextField!
    @IBOutlet weak var myAddress: UIButton!
    @IBOutlet weak var receiverAddress: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gasLimit.keyboardType = .numberPad
        self.gasFees.keyboardType = .numberPad
        self.amountToBeSend.keyboardType = .numberPad
        self.setupGasFees()
        self.setMyAddress()
        self.getBalance()
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
        self.myAddressButton.setTitle(UserDefaultsManager.shared.getCurrentNetworkWalletAddress(), for: .normal)
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
        
        self.present(ScannerViewController(), animated: true, completion: nil)
        
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


extension SendTokenTableViewController {
    

//        func getXdcPrice(xdcVal: BigUInt) {
//
//            let xdcValueInDouble = Double(xdcVal)
//
//
//            AlamoObject.getXdcUsdPrice() { price in
//
//                let price = xdcValueInDouble * price
//
//                DispatchQueue.main.async {
//                    self.usdBalance.text = "$\(price.rounded(toPlaces: 2)) USD"
//                }
//
//            }
//
//
//        }
}