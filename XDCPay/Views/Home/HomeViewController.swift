
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMenuDrawer()
    }
}

 

extension HomeViewController:MenuDrawerProtocol {
    
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




 
 
