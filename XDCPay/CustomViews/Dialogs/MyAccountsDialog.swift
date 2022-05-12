//
//  MyAccountsDialog.swift
//  XDCPay
//
//  Created by Admin on 01/04/22.
//

import UIKit

class MyAccountsDialog: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accountViewHeightConstraints: NSLayoutConstraint!
    
    var accounts = [Account]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        accounts.removeAll()
        accounts = DataBaseManager.shared.getAccounts()
        if (accounts.count > 3) {
            accountViewHeightConstraints.constant = 132
            tableView.isScrollEnabled = true
        } else {
            accountViewHeightConstraints.constant = CGFloat(44 * accounts.count)
            tableView.isScrollEnabled = false
        }
        self.tableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let account = accounts[indexPath.row]
        
        UserDefaultsManager.shared.updateWalletData(address: account.address, privateKey: account.rawPrivateKey, rawPublicKey: account.rawPublicKey)
        
        self.LoadingStart()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            self.LoadingStop()
            
            SceneDelegate.shared?.checkLogin()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let account =  self.accounts[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AccountCell") as! AccountCell
        cell.deleteButton.tag = indexPath.row
        cell.accountLabel.text = account.accountName
        
        if(account.canDelete == "No") {
            cell.deleteButton.isHidden = true
            cell.importedLabel.isHidden = true
        }else {
            cell.deleteButton.isHidden = false
            cell.importedLabel.isHidden = false
        }
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        
        return cell
        
    }
    
    
    @objc func deleteButtonTapped(_ sender: UIButton){
        
        selectedIndex = sender.tag
        
        self.pVC(viewConterlerId: "DeleteDialog")
    }
    
    
    @IBAction func onCreateAccount(_ sender: Any) {
        
        self.pVC(viewConterlerId: "AddAccountDialog")
    }
    
    @IBAction func onImportAccount(_ sender: Any) {
        
        self.pVC(viewConterlerId: "ImportAccountViewController")
        
    }
    
}
