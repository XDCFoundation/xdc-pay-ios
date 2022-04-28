 
 import UIKit
  
 var selectedIndex = 0
 
 class DeleteDialog: UIViewController {
    
    @IBOutlet weak var amount: UILabel!
    
    
    override func viewDidLoad() {
        self.amount.text =  "Available Amount: "  +  homeVc.mainBalance.text!
    }
    
  
    @IBAction func onDelete(_ sender: Any) {
        
        
        self.LoadingStart()
        
        DataBaseManager.shared.deleteAccount(selectedIndex:selectedIndex)
          
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           
            self.LoadingStop()
            
            SceneDelegate.shared?.checkLogin()
        
           // self.dismiss(animated: true, completion: nil)
            
        }
      
      // self.dismiss(animated: true, completion: nil)
        
    }
    
 }

