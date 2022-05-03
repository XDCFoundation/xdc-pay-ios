//
//  NetworkDetailsViewController.swift
//  XDCPay
//
//  Created by Admin on 31/03/22.
//

import UIKit

class NetworkDetailsViewController: UIViewController {

    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rpc: UILabel!
    var selectedIndex = 0
    var network : Network?
    
    @IBOutlet weak var deleteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deleteButton.isHidden = true
        
        if self.network!.isEditable == "Yes" {
            self.deleteButton.isHidden = false
        }
        
        
        if(network != nil){
            self.setupView()
        }

    }
    
    
    @IBAction func onDelete(_ sender: Any) {
        
        self.LoadingStart()
        
        DataBaseManager.shared.deleteNetwork(selectedIndex:selectedIndex)
          
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           
            self.LoadingStop()
            UserDefaultsManager.shared.setOrUpdateCurrentNetwork(url:  DataBaseManager.shared.getNetworks().first!.rpc)
            SceneDelegate.shared?.checkLogin()
        }
        
    }
    
    func setupView() {
        self.url.text    = network?.url
        self.symbol.text = network?.symbol
        self.id.text = network?.id
        self.name.text = network?.name
        self.rpc.text = network?.rpc
        
    }
    

     

}
