//
//  MyAccountsDialog.swift
//  XDCPay
//
//  Created by Admin on 01/04/22.
//

import UIKit

class MyAccountsDialog: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "AccountCell") as! AccountCell
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
         
        return cell
        
    }
    
    
    @objc func deleteButtonTapped(_ sender: UIButton){

        self.pVC(viewConterlerId: "DeleteDialog")
    }
   

    @IBAction func onCreateAccount(_ sender: Any) {
       
        self.pVC(viewConterlerId: "AddAccountDialog")
    }
    
    @IBAction func onImportAccount(_ sender: Any) {
        
        self.pVC(viewConterlerId: "ImportAccountViewController")
        
    }
    
    
    
}
