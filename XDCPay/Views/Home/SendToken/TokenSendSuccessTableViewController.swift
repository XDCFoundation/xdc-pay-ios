//
//  TokenSendSuccessTableViewController.swift
//  XDCPay
//
//  Created by Admin on 06/04/22.
//

import UIKit

var tempData = [String:String]()



class TokenSendSuccessTableViewController: UITableViewController {
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var fees: UILabel!
    @IBOutlet weak var gwei: UILabel!
    @IBOutlet weak var gasLimit: UILabel!
    @IBOutlet weak var myAddress: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var toAddress: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.myAddress.text = UserDefaultsManager.shared.getCurrentAccoutWalletAddress()
        self.gwei.text = tempData["gwei"]
        self.toAddress.text = tempData["recipientAddress"]
        self.amount.text = tempData["amount"]
        self.gasLimit.text = tempData["gasLimit"]
        self.total.text = tempData["total"]
        self.fees.text = tempData["fee"]
        self.myAddress.text = tempData["myAddress"]
       

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
