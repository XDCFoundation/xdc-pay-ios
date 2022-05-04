 
import XDC3Swift
import Foundation

 class XDCClientManager {
    
    static var shared =  XDCClientManager()
    
    func getXDCClient() -> XDCClient {
        
      let currentNetwork =  UserDefaultsManager.shared.getCurrentNetworkRpc()
        
      print(currentNetwork)
      return  XDCClient(url: URL(string: currentNetwork)!)
        
    }
 }

