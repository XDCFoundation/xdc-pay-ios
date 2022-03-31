//
//  SettingsViewController.swift
//  XDCPay
//
//  Created by Admin on 30/03/22.
//
import  UIKit

class SettingsViewController : UIViewController, UITableViewDelegate , UITableViewDataSource{
   
    var titles = ["General Settings", "Advance Settings" , "Security & Privacy" , "Networks" , "Contacts"]
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewController = UIViewController()
    
    override func viewDidLoad() {
        
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SettingMenuCell") as! SettingMenuCell
        cell.menuTitle.text = self.titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
       
        
        switch indexPath.row {
        
        case 0:
             
         viewController = self.storyboard?.instantiateViewController(withIdentifier: "GenralSettingsViewController") as! GenralSettingsViewController
      
            
        case 1:
            viewController = self.storyboard?.instantiateViewController(withIdentifier: "AdvanceSettingsViewController") as! AdvanceSettingsViewController
            
        case 2:
            viewController = self.storyboard?.instantiateViewController(withIdentifier: "SecurityViewController") as! SecurityViewController
            
        case 3:
            viewController = self.storyboard?.instantiateViewController(withIdentifier: "NetworkViewController") as! NetworkViewController
            
            
            
        default:
            print("")
        }
        
        viewController.modalPresentationStyle = .fullScreen
        
        self.present(viewController, animated: true, completion: nil)
        
        
    }
}

