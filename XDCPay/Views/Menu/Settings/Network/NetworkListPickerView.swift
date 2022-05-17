 
import UIKit

class NetworkListPickerView: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var tableContainer: UIView!
    
    @IBOutlet weak var tableContainerHHeight: NSLayoutConstraint!
    
    var currentNetworkName = ""
    
    var completionHandler:((Int) -> Void)?
    var networks = [Network]()
    var cellHeight:CGFloat = 60.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.titleView.clipsToBounds = true
        self.titleView.layer.cornerRadius = 10
        self.titleView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        self.currentNetworkName = UserDefaultsManager.shared.getCurrentNetworName()
        
        networks.removeAll()
        
        networks = DataBaseManager.shared.getNetworks()
        
        self.handelTableHeight()
        self.tableView.reloadData()
        
        
    }
    
    
    func handelTableHeight()  {
         
        self.tableView.isScrollEnabled = false
        
        if(networks.count == 3) {
            self.tableContainerHHeight.constant = 200
        }
        
        if(networks.count == 4) {
            self.tableContainerHHeight.constant = 200 + 10
        }
        
        if(networks.count == 5) {
            self.tableContainerHHeight.constant = 200 + cellHeight
        }
        
        if(networks.count == 6) {
            self.tableContainerHHeight.constant = 200 + cellHeight * 2
        }
        
        if(networks.count >  6) {
            self.tableContainerHHeight.constant = 200 + cellHeight * 2
            self.tableView.isScrollEnabled = true
        }
        
    }
 
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let network = networks[indexPath.row]
        
        UserDefaultsManager.shared.setOrUpdateCurrentNetworkRpc(url: network.rpc)
        UserDefaultsManager.shared.setOrUpdateCurrentNetworkName(name: network.name)
        SceneDelegate.shared?.checkLogin()

        self.LoadingStart()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.LoadingStop()
            SceneDelegate.shared?.checkLogin()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let network =  self.networks[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "NetwrokListCell") as! NetwrokListCell
        cell.networkName.text = network.name
        
        if(currentNetworkName == network.name ) {
            cell.checkMark.isHidden = false
            cell.networkName.textColor =  UIColor.init(hexString: "2149B9")
        }else {
            cell.checkMark.isHidden = true
            cell.networkName.textColor = UIColor.black
        }
        
        return cell
        
    }
    

}
