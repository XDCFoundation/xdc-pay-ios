//
//  ContactsViewController.swift
//  XDCPay
//
//  Created by Admin on 01/04/22.
//

import UIKit

class ContactsViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    
    var contactDictionary = [String: [String]]()
    var contactitles = [String]()
    var contacts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getContacts()
    }
    
    func getContacts() {
        
        contacts.removeAll()
        contactDictionary.removeAll()
        contactitles.removeAll()
        
        contacts = DataBaseManager.shared.getContacts().map{$0.name}
              for contact in contacts {
                  let contactKey = String(contact.prefix(1))
                  if var carValues = contactDictionary[contactKey] {
                      carValues.append(contact)
                      contactDictionary[contactKey] = carValues
                  } else {
                    contactDictionary[contactKey] = [contact]
                  }
              }
        
              contactitles = [String](contactDictionary.keys)
              contactitles = contactitles.sorted(by: { $0 < $1 })
        
        self.tableView.tableHeaderView?.backgroundColor = UIColor.red
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           let contactKey = contactitles[section]
           if let contactValues = contactDictionary[contactKey] {
               return contactValues.count
           }
           
           return 0
    }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell

           // Configure the cell...
           let carKey = contactitles[indexPath.section]
           if let carValues = contactDictionary[carKey] {
               cell.contactName?.text = carValues[indexPath.row]
           }

           return cell
       }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return contactitles[section]
       }

       
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
           return contactitles
   }
    
      

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactDetailViewController") as! ContactDetailViewController
        vc.modalPresentationStyle = .fullScreen
        let contactKey = contactitles[indexPath.section]
        let contactName = contactDictionary[contactKey]![indexPath.row]
        vc.contactName =  contactName
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func onAddContact(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddContactViewController") as! AddContactViewController
        vc.titleText = "Add Contact"
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
