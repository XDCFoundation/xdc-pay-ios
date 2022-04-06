//
//  ContactsViewController.swift
//  XDCPay
//
//  Created by Admin on 01/04/22.
//

import UIKit

class ContactsViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    
    var carsDictionary = [String: [String]]()
    var carSectionTitles = [String]()
    var cars = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        cars = ["Audi", "Aston Martin","BMW", "Bugatti", "Bentley","Chevrolet", "Cadillac","Dodge","Ferrari", "Ford","Honda","Jaguar","Lamborghini","Mercedes", "Mazda","Nissan","Porsche","Rolls Royce","Toyota","Volkswagen"]
              
              for car in cars {
                  let carKey = String(car.prefix(1))
                  if var carValues = carsDictionary[carKey] {
                      carValues.append(car)
                      carsDictionary[carKey] = carValues
                  } else {
                      carsDictionary[carKey] = [car]
                  }
              }
              
              carSectionTitles = [String](carsDictionary.keys)
              carSectionTitles = carSectionTitles.sorted(by: { $0 < $1 })
        
        self.tableView.tableHeaderView?.backgroundColor = UIColor.red
      
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return carSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           let carKey = carSectionTitles[section]
           if let carValues = carsDictionary[carKey] {
               return carValues.count
           }
           
           return 0
    }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell

           // Configure the cell...
           let carKey = carSectionTitles[indexPath.section]
           if let carValues = carsDictionary[carKey] {
               cell.contactName?.text = carValues[indexPath.row]
           }

           return cell
       }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return carSectionTitles[section]
       }

       
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
           return carSectionTitles
   }
    
      

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pVC(viewConterlerId: "ContactDetailViewController")
    }
    @IBAction func onAddContact(_ sender: Any) {
        
        self.pVC(viewConterlerId: "AddContactViewController")
    }
    
    
}
