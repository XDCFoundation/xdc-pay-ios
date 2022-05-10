
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
        self.addressText.text = self.accountAddress
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
        let pickerViewClass = self.storyboard?.instantiateViewController(withIdentifier: "PickerViewClass") as! PickerViewClass
        let networks = DataBaseManager.shared.getNetworks()
        pickerViewClass.pickerData = networks.map{$0.name}
        pickerViewClass.titleName = "Network"
        self.present(pickerViewClass, animated: true, completion: nil)
        pickerViewClass.completionHandler = { selectedRow in
            self.networkName.text =  networks[selectedRow].name
            UserDefaultsManager.shared.setOrUpdateCurrentNetworkRpc(url: networks[selectedRow].rpc)
            UserDefaultsManager.shared.setOrUpdateCurrentNetworkName(name: networks[selectedRow].name)
            SceneDelegate.shared?.checkLogin()
        }
    }
    
    @IBAction func onCopyAddress(_ sender: Any) {
        self.showCopyToast()
      //  MessageDisplayer.showMessage(message: "Copy")
      //  self.showToast(message: "Copied", font: .systemFont(ofSize: 14.0), view: addressView)
        UIPasteboard.general.string =  UserDefaultsManager.shared.getCurrentAccoutWalletAddress()
    }
    func getBalance() {
        
        
        self.client!.eth_getBalance(address: XDCAddress(UserDefaultsManager.shared.getMainWalletAddress()), block: .Latest) { (error, balanceOf) in
            
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

