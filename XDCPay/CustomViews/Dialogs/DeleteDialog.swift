 
 import UIKit
 
 var selectedIndex = 0
 
 class DeleteDialog: UIViewController {
    
  
    @IBAction func onDelete(_ sender: Any) {
        
        
        self.LoadingStart()
        
        DataBaseManager.shared.deleteAccount(selectedIndex:selectedIndex)
          
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           
            self.LoadingStop()
        
            self.dismiss(animated: true, completion: nil)
            
        }
      
       self.dismiss(animated: true, completion: nil)
        
    }
    
 }

