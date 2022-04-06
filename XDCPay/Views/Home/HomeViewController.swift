
import UIKit

class HomeViewController: UIViewController {
    
    @IBAction func onSend(_ sender: Any) {
        
        self.pVC(viewConterlerId: "SendTokenViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMenuDrawer()
    }
}

 

extension HomeViewController:MenuDrawerProtocol {
    
    
    func onAccount() {
        
        let pickerViewClass = self.storyboard?.instantiateViewController(withIdentifier: "MyAccountsDialog") as! MyAccountsDialog
                        
       
                            self.present(pickerViewClass, animated: true, completion: nil)
//                           pickerViewClass.completionHandler = { selectedRow in
//                              // self.positionButton.setTitle( self.positionArray[selectedRow], for: .normal)
//                              // self.selectedIndex = selectedRow
//                               return  50
//        }
        
            
        
       
    }
    
    
    func setupMenuDrawer() {
        
        menuDrawer.setTableViewData(data: ["View on Observatory" , "Settings" , "Info/Help" , "Logout"], images: ["View on observatory" , "Settings" , "Info" , "Log out"])
         
        
        menuDrawer.initialize(view: self.view) 
      
        delegateMenuDrawer = self
    }
    
    
    func onSelectRow(row: Int) {
        
        
                switch row {
                case 0:
                    print("1")
                case 1:
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true, completion: nil)
        
                    
                default:
                    print("Default")
                }
        
    }
   
    
}




 
 
