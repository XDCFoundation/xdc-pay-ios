
import Foundation
 


class DataBaseManager {
    
  
  static let shared = DataBaseManager()
    
    func addNetwork(name:String,rpc:String,id:String,symbol:String,url:String) {
        
        let savedNetworks =   geNetworkJSON()

        if(savedNetworks.isEmpty) {
            
            let data = [
                "name": name,
                "rpc": rpc,
                "id": id,
                "symbol": symbol,
                "url": url,
            ]
            
            let jsonArray = ["response" : [data] ]
            
            print(jsonArray)
            
            let str = String(data: try! JSONEncoder().encode(jsonArray), encoding: .utf8)
            print(str as Any)
            
            self.saveNetwork(data: (str!))
            
            
        }else {
            
            
            let dataJson = savedNetworks.data(using: .utf8)!

            var networks = try! JSONDecoder().decode(AllNetworks.self, from: dataJson)
         
            networks.responseData!.append(Network(name: name, rpc: rpc, id: id, symbol: symbol, url: url))
            
            let str = String(data: try! JSONEncoder().encode(networks), encoding: .utf8)
            print(str as Any)
            
            self.saveNetwork(data: (str!))
            
        }
        
    }
    
    func getNetworks() -> [Network] {
       
       
        let networkJSONString = geNetworkJSON()

        print(networkJSONString)
        
        if(networkJSONString.isEmpty){
            return [Network]()
        }
        
        let dataJson = networkJSONString.data(using: .utf8)!

        let networks = try! JSONDecoder().decode(AllNetworks.self, from: dataJson)
        
        return networks.responseData!
 
    }

    
    func demo() {
        
       // self.getNetworks()
        
        self.addNetwork(name: "TEstNew", rpc: "RPC", id: "DEMOid", symbol: "USD", url: "URLLS")
       
    }
  
}



extension DataBaseManager {
    
    
  private func saveNetwork(data:String) {
        
        UserDefaults.standard.setValue(data, forKey: "networkJSON")
       
    }
    
    func geNetworkJSON() ->String {
        
        UserDefaults.standard.value(forKey: "networkJSON") as? String ?? ""
       
    }
    
}
