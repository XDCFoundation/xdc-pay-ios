//
//  ItemViewController.swift
//  ViewPager-Swift
//
//  Created by Nishan on 2/9/16.
//  Copyright © 2016 Nishan. All rights reserved.
//

import UIKit
import XDC3Swift

var viewPagerItemViewController : ViewPagerItemViewController?

class ViewPagerItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var addTokenButton: UIButton!
    
    var transactions = [Transaction]()
    var tokens = [TokenDetails]()
    
    
    var position = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        viewPagerItemViewController = self
         
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: "TransactionCell")
        self.tableView.register(UINib(nibName: "TokenCell", bundle: nil), forCellReuseIdentifier: "TokenCell")
       
        self.transactions = DataBaseManager.shared.getTransactions().filter{$0.myAddress == UserDefaultsManager.shared.getCurrentAccoutWalletAddress()}
      
        self.tokens = DataBaseManager.shared.getTokens()
        //Token or NFT
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addTokenButton.isHidden = true
    }
    
    @IBAction func addTokenBtnAction(_ sender: UIButton) {
     //   MessageDisplayer.showMessage(message: "Under development")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddTokenViewController") as! AddTokenViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - UITableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(position == 0) {
            return transactions.count
        }
        self.addTokenButton.isHidden = false
        return tokens.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(position == 0) {
            
            self.addTokenButton.isHidden = true
            
            let transction = self.transactions[indexPath.row]
 
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
            
            cell.transactionHash.text = transction.hash
            cell.symbol.text = "XDC"
            cell.amount.text =  transction.amount
            cell.time.text = transction.time

            return cell
           
            
        } else {
            let tokenData = self.tokens[indexPath.item]

            let cell = self.tableView.dequeueReusableCell(withIdentifier: "TokenCell", for: indexPath) as! TokenCell
            TokenManager.shared._balanceToken(_contractAddress: tokenData.tokenAddress.xdc3.noxdcPrefix.xdc3.withHexPrefix) { balance in
                DispatchQueue.main.async {
                    let mainBalance = Double(balance!)!/pow(10.0, Double(tokenData.tokenDecimal)!)
                    cell.tokenDetails.text = "\(String(describing: Int(mainBalance))) \(tokenData.tokenSymbol)"
                }
            } onError: { error in
                DispatchQueue.main.async {
                    cell.tokenDetails.text = "0 \(tokenData.tokenSymbol)"
                }
            }
           
            return cell
        }
         
    }
    
    
}

