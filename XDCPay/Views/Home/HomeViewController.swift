
import UIKit
import XDC3Swift
import BigInt

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mainBalance: UILabel!
    @IBOutlet weak var usdBalance: UILabel!
    
    let client = XDCClient(url: URL(string: testConfig.xinfinNetworkUrl)!)
    let AlamoObject = AlamoWebServices()
    @IBOutlet weak var addressText: UILabel!
    
    var accountAddress = ""
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainBalance.text =  "0 XDC"
        self.usdBalance.text = "$0 USD"
        self.accountAddress = UserDefaultsManager.shared.getCurrentWalletAddress0x()
        self.setupMenuDrawer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.getBalance()
    }
    
    @IBAction func onCopyAddress(_ sender: Any) {
        UIPasteboard.general.string =  UserDefaultsManager.shared.getCurrentWalletAddress0x()
    }
    func getBalance() {
        
       
        self.client.eth_getBalance(address: XDCAddress(UserDefaultsManager.shared.getMainWalletAddress()), block: .Latest) { (error, balanceOf) in
                
            if (balanceOf != nil){
                let value = balanceOf!/1000000000000000000
                print(value)
               
              DispatchQueue.main.async {
                  self.mainBalance.text =  "\(value) XDC"
                   self.getXdcPrice(xdcVal: value)
              }
            }
              
        }
    }
    
    
    @IBAction func onScanSend(_ sender: Any) {
        
        
        let scaner = ScannerViewController()
        self.present(scaner, animated: true, completion: nil)
        scaner.completionHandler = { qrCode in
        
            if(!qrCode.isEmpty) {
                globaReceiverAddress = qrCode
                
                DispatchQueue.main.sync {
                    self.pVC(viewConterlerId: "SendTokenViewController")
                }
            }
        }
        
    }
    
    @IBAction func onReceive(_ sender: Any) {
        self.pVC(viewConterlerId: "ReceiveViewController")
    }
    
    @IBAction func onSend(_ sender: Any) {
        globaReceiverAddress = ""
        self.pVC(viewConterlerId: "SendTokenViewController")
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
                    openObservatory()
                case 1:
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true, completion: nil)
                case 2:
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "InfoHelpVC") as! InfoHelpVC
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true, completion: nil)
        
                case 3:
                    self.logout()
                    
                default:
                    print("Default")
                }
        
    }
    
    func logout() {
         //UserDefaultsManager.shared.clearUserDefaults()
         UserDefaultsManager.shared.logOut()
         SceneDelegate.shared?.checkLogin()
         
    }
    
    func openObservatory() {
        
        let walletData = UserDefaults.standard.array(forKey: "WalletData")
        
        guard let walletAddress = walletData![0] as? String else {
            return
        }
        
        let walletUrl = "https://observer.xdc.org/address-details/\(walletAddress)"
        
        if let url = URL(string: walletUrl) {
            UIApplication.shared.open(url)
        }
    }
    
}



extension HomeViewController {
    
    func getXdcPrice(xdcVal: BigUInt) {
      
        let xdcValueInDouble = Double(xdcVal)

        
        AlamoObject.getXdcUsdPrice() { price in
           
            let price = xdcValueInDouble * price
            
            DispatchQueue.main.async {
                self.usdBalance.text = "$\(price.rounded(toPlaces: 2)) USD"
            }
            
        }
 
        
    }
}


 
 
struct testConfig{
  static let xinfinNetworkUrl = "https://rpc.apothem.network"
  
}
