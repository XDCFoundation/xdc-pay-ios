//
//  ContactDetailViewController.swift
//  XDCPay
//
//  Created by Admin on 01/04/22.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    @IBOutlet weak var noTransaction: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    var id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contacts = DataBaseManager.shared.getContacts()
        let contact =  contacts.filter{$0.id == id}.first
        self.name.text = contact!.name
        self.address.text = contact!.address
    
    }
    

    @IBAction func onEdit(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditContactViewController") as! EditContactViewController
        vc.modalPresentationStyle = .fullScreen
        vc.addressText = self.address.text!
        vc.nameText =  self.name.text!
        vc.id = self.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onCopy(_ sender: Any) {
          showCopyToast()
          UIPasteboard.general.string = self.address.text!
    }
    

}
