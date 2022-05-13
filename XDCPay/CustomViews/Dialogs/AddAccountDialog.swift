 

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
        
        self.LoadingStart()
        
        DataBaseManager.shared.addAccount(accountName: self.account.text!)
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           
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

