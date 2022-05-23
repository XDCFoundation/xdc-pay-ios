 

import UIKit

class AddAccountDialog: UIViewController {
    
    
    @IBOutlet weak var account: UITextField!
    
    override func viewDidLoad() {
        self.account.delegate = self
    }
   
    @IBAction func onAdd(_ sender: Any) {
        
        if(self.account.text!.isEmpty) {
            return
        }
        
        var accountFound = false
        
        for account in DataBaseManager.shared.getAccounts() {
         
            if(account.accountName.lowercased() == self.account.text!.lowercased()) {
                accountFound = true
                break
            }
        }
       
        if(accountFound) {
            showAlert(message: "Account Name Already Used, Please use diffrent Name")
            return
        }
        
        self.LoadingStart()
        
        DataBaseManager.shared.addAccount(accountName: self.account.text!)
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           
            self.LoadingStop()

            self.dismiss(animated: true, completion: nil)
            
        }        
    }
}

extension AddAccountDialog: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 20
    }
}

