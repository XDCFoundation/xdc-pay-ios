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
    var network : Network?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(network?.name)

    }
    

     

}
