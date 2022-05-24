
import UIKit
import XDC3Swift
import BigInt

var homeVc : HomeViewController!

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mainBalance: UILabel!
    @IBOutlet weak var usdBalance: UILabel!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var networkName: UILabel!
    @IBOutlet weak var addressText: UILabel!
    @IBOutlet weak var addressView: UIView!
    
    var client : XDCClient?
    let AlamoObject = AlamoWebServices()
    var accountAddress = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.client = XDCClientManager.shared.getXDCClient()
        self.mainBalance.text =  "0 XDC"
        self.usdBalance.text = "$0 USD"
        homeVc = self
        self.accountAddress = UserDefaultsManager.shared.getCurrentAccoutWalletAddress()
        self.setMyAddress(str: self.accountAddress)
        self.setupMenuDrawer()
        self.accountName.text = DataBaseManager.shared.getCurrentAccountName()
        self.networkName.text = UserDefaultsManager.shared.getCurrentNetworName()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getBalance()
       // viewPagerItemViewController!.tableView.reloadData()
    }
    
    @IBAction func onBuy(_ sender: Any) {
        self.pVC(viewConterlerId: "BuyVC")
    }
    @IBAction func onNetworkName(_ sender: Any) {
        let pickerViewClass = self.storyboard?.instantiateViewController(withIdentifier: "NetworkListPickerView") as! NetworkListPickerView
        self.present(pickerViewClass, animated: true, completion: nil)
    }
    
    @IBAction func onCopyAddress(_ sender: Any) {
        self.showCopyToast()
        UIPasteboard.general.string =  UserDefaultsManager.shared.getCurrentAccoutWalletAddress()
    }
    func getBalance() {
        self.client!.eth_getBalance(address: XDCAddress(UserDefaultsManager.shared.getMainWalletAddress()), block: .Latest) { (error, balanceOf) in
 
      if (balanceOf != nil){
                let value =  Double(balanceOf!)/1000000000000000000
        
                DispatchQueue.main.async {
                    
                    self.mainBalance.text = value.getXDCValue()
                    self.getXdcPrice(xdcVal: value)
                    
                }
            }
        }
    }
    
    func setMyAddress(str:String) {
        let index = str.index(str.startIndex, offsetBy: 7)
        let mySubstring1 = str[..<index]
        
        let index2 = str.index(str.endIndex, offsetBy: -4)
        let mySubstring2 = str[index2...] // playground
        
        let truncateStr = mySubstring1 + "..." + mySubstring2
        self.addressText.text = "\(truncateStr)"
    }
    
    @IBAction func onScanSend(_ sender: Any) {
        
        
        let scaner = ScannerViewController()
        self.present(scaner, animated: true, completion: nil)
        scaner.completionHandler = { qrCode in
            
            if(!qrCode.isEmpty) {
                globaReceiverAddress = qrCode
                
                DispatchQueue.main.async {
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
    
    func onEditAccountName() {
        
        let alertController = UIAlertController(title: "Edit name", message: "This will be your new account name", preferredStyle: .alert)

         
        let saveAction = UIAlertAction(title: "Done", style: .default, handler: { alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
          
            if(firstTextField.text!.isEmpty) {
                return
            }else {
                DataBaseManager.shared.updateAccountName(name:firstTextField.text!)
                SceneDelegate.shared?.checkLogin()
            }
            
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Account Name"
            textField.text = DataBaseManager.shared.getCurrentAccountName()
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
         
        self.present(alertController, animated: true, completion: nil)
        
    }
    
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
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingNC") as! UINavigationController
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
        
       
        let network = DataBaseManager.shared.getNetworks().filter{$0.name == UserDefaultsManager.shared.getCurrentNetworName()}.first!
      
        let networkURL = network.url
        
        if(networkURL.isEmpty) {
            showAlert(message: "Network url is Empty")
            return
        }
        
        
        if(!networkURL.isValidateURL()) {
            self.showAlert(message: "URL is Not Correct")
            return
        }
        
        
        
          if(network.url.contains("observer.xdc.org")) {
              
              let walletUrl = "https://observer.xdc.org/address-details/\(walletAddress)"
              
              if let url = URL(string: walletUrl) {
                  UIApplication.shared.open(url)
              }
          }else {
            
            if let url = URL(string: networkURL) {
                UIApplication.shared.open(url)
            }
            
          }
       
    }
    
}



extension HomeViewController {
    
    func getXdcPrice(xdcVal: Double) {
        
        let xdcValueInDouble = Double(xdcVal)
        
        
        AlamoObject.getXdcUsdPrice() { price in
            
            let price = xdcValueInDouble * price
            
            DispatchQueue.main.async {
                self.usdBalance.text = "$\(price.rounded(toPlaces: 3)) USD"
            }
            
        }
        
        
    }
}

 

extension Int {

    func formatUsingAbbrevation () -> String {
        let numFormatter = NumberFormatter()

        typealias Abbrevation = (threshold:Double, divisor:Double, suffix:String)
        let abbreviations:[Abbrevation] = [(0, 1, ""),
                                           (1000.0, 1000.0, "K"),
                                           (100_000.0, 1_000_000.0, "M"),
                                           (100_000_000.0, 1_000_000_000.0, "B")]
                                           // you can add more !

        let startValue = Double (abs(self))
        let abbreviation:Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if (startValue < tmpAbbreviation.threshold) {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        } ()

        let value = Double(self) / abbreviation.divisor
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativeSuffix = abbreviation.suffix
        numFormatter.allowsFloats = true
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1

        return numFormatter.string(from: NSNumber (value:value))!
    }

}
 
 
