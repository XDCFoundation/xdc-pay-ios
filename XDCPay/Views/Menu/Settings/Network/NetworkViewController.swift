//
//  NetworkViewController.swift
//  XDCPay
//
//  Created by Admin on 30/03/22.
//

import UIKit

class NetworkViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var noNetworkLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var networks = [Network]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        networks.removeAll()
        
        networks = DataBaseManager.shared.getNetworks()
        
        if(networks.isEmpty) {
            noNetworkLabel.isHidden = false
        }else {
            noNetworkLabel.isHidden = true
        }
        self.tableView.reloadData()
        
    }
    
   
    
    @IBAction func onAddNetwork(_ sender: Any) {
        self.pVC(viewConterlerId: "AddNetworkViewController")
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return networks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "NetworkCell") as! NetworkCell
        cell.menuTitle.text = self.networks[indexPath.row].name
        cell.roundView.backgroundColor = UIColor.random()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Storyboard2", bundle: nil).instantiateViewController(withIdentifier: "NetworkDetailsViewController") as! NetworkDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        vc.network = self.networks[indexPath.row]
        self.present(vc, animated: true, completion: nil)
        
        
    }
   

}
