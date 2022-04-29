//
//  ItemViewController.swift
//  ViewPager-Swift
//
//  Created by Nishan on 2/9/16.
//  Copyright © 2016 Nishan. All rights reserved.
//

import UIKit

class ViewPagerItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var addTokenButton: UIButton!
    
    var position = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
         
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: "TransactionCell")
        self.tableView.register(UINib(nibName: "TokenCell", bundle: nil), forCellReuseIdentifier: "TokenCell")
       
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(position == 0) {
            return 5
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(position == 0) {
            
            self.addTokenButton.isHidden = true
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
            return cell
            
            
        }else {
            self.addTokenButton.isHidden = false
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "TokenCell", for: indexPath) as! TokenCell
            return cell
        }
         
        
         
    }
    
    
}

