//
//  ItemViewController.swift
//  ViewPager-Swift
//
//  Created by Nishan on 2/9/16.
//  Copyright © 2016 Nishan. All rights reserved.
//

import UIKit

var viewPagerItemViewController : ViewPagerItemViewController?

class ViewPagerItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var addTokenButton: UIButton!
    
    var transactions = [Transaction]()
    
    
    var position = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        viewPagerItemViewController = self
         
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: "TransactionCell")
        self.tableView.register(UINib(nibName: "TokenCell", bundle: nil), forCellReuseIdentifier: "TokenCell")
       
        self.transactions = DataBaseManager.shared.getTransactions().filter{$0.myAddress == UserDefaultsManager.shared.getCurrentAccoutWalletAddress()}
     
        //MARK: -> Token or NFT
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addTokenButton.isHidden = true
    }
    
    @IBAction func addTokenBtnAction(_ sender: UIButton) {
        MessageDisplayer.showMessage(message: "Under development")
    }
    
    //MARK: - UITableview Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(position == 0) {
            return transactions.count
        }
        return 2
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
            self.addTokenButton.isHidden = false
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "TokenCell", for: indexPath) as! TokenCell
            return cell
        }
         
    }
    
    
}

