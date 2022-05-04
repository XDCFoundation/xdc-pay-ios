
import Foundation

import XDC3Swift


class DataBaseManager {
    
    
  
  static let shared = DataBaseManager()
    
    func addNetwork(name:String,rpc:String,id:String,symbol:String,url:String,isEditable:String) {
        
        let savedNetworks =  geNetworkJSON()

        if(savedNetworks.isEmpty) {
            
            let data = [
                "name": name,
                "rpc": rpc,
                "id": id,
                "symbol": symbol,
                "url": url,
                "isEditable": isEditable
            ]
            
            let jsonArray = ["response" : [data] ]
            
            print(jsonArray)
            
            let str = String(data: try! JSONEncoder().encode(jsonArray), encoding: .utf8)
            print(str as Any)
            
            self.saveNetwork(data: (str!))
            
            
        }else {
            
            
            let dataJson = savedNetworks.data(using: .utf8)!

            var networks = try! JSONDecoder().decode(AllNetworks.self, from: dataJson)
         
            networks.responseData!.append(Network(name: name, rpc: rpc, id: id, symbol: symbol, url: url, isEditable: isEditable))
            
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
}


extension DataBaseManager {
    
    
    private func saveNetwork(data:String) {
        
        UserDefaults.standard.setValue(data, forKey: "networkJSON")
       
    }
    
    func geNetworkJSON() ->String {
        
        UserDefaults.standard.value(forKey: "networkJSON") as? String ?? ""
       
    }
    
}


extension DataBaseManager {
    
    
    
    func geAccountJSON() ->String {
        
        UserDefaults.standard.value(forKey: "accounts") as? String ?? ""
       
    }
    
    private func saveAccount(data:String) {
        
        UserDefaults.standard.setValue(data, forKey: "accounts")
       
    }
    
    func getCurrentAccountName() ->String {
        
        var name = ""
        
        let accountJsonString = geAccountJSON()

        if(!accountJsonString.isEmpty) {
            
            let dataJson = accountJsonString.data(using: .utf8)!

            let currentAddress =  UserDefaultsManager.shared.getWalletAddress()
            
            let accounts = try! JSONDecoder().decode(AllAccounts.self, from: dataJson)
            
            for item in accounts.responseData! {
                
                if(item.address == currentAddress){
                    name = item.accountName
                    break
                }
            }
            
        }
        
        return name
        
      
        
    }
    
    func getAccounts() -> [Account] {
       
        let accountJsonString = geAccountJSON()

        print(accountJsonString)
        
        if(accountJsonString.isEmpty){
            return [Account]()
        }
        
        let dataJson = accountJsonString.data(using: .utf8)!

        let accounts = try! JSONDecoder().decode(AllAccounts.self, from: dataJson)
        
        return accounts.responseData!
 
    }
    
    
    
    private func setupNewAccount() -> (String,String,String,String) {
        
        let acc = try! XDCAccount.createAccountWithMemonic()
        let mnemonic = try! XDCAccount.importAccountWithMnemonic(mnemonic: acc)
         
        return ( mnemonic.rawPrivateKey , mnemonic.rawPublicKey , mnemonic.privateKey.get(), mnemonic.address)
     
    }
     
    
    func addAccount(accountName:String) {
        
        let savedAccounts = geAccountJSON()

            let dataJson = savedAccounts.data(using: .utf8)!

            var accounts = try! JSONDecoder().decode(AllAccounts.self, from: dataJson)
         
            let account = setupNewAccount()
            
            accounts.responseData!.append(Account(rawPrivateKey: account.0, rawPublicKey: account.1, privateKey: account.2, address: account.3, accountName: accountName , canDelete: "No"))
            
            let str = String(data: try! JSONEncoder().encode(accounts), encoding: .utf8)
            print(str as Any)
            
            self.saveAccount(data: (str!))
            
     }
    
    func saveDefaultAccount(address:String, privateKey:String, publicKey:String) {
        
        
        let data = [
            "rawPrivateKey": privateKey ,
            "rawPublicKey": publicKey,
            "privateKey": privateKey,
            "address": address,
            "accountName": "Account 1",
            "canDelete": "No",
        ]
        
        let jsonArray = ["response" : [data] ]
         
        print(jsonArray)
        
        let str = String(data: try! JSONEncoder().encode(jsonArray), encoding: .utf8)
        print(str as Any)
        
        self.saveAccount(data: (str!))
        
        
    }
    
    func importAccount(rowPrivateKey:String) {
        
           let account = try? XDCAccount(keyStorage: XDCPrivateKeyStore(privateKey: rowPrivateKey))
    
             let savedAccounts = geAccountJSON()

             let dataJson = savedAccounts.data(using: .utf8)!

             var accounts = try! JSONDecoder().decode(AllAccounts.self, from: dataJson)
         
             let accountName = "Account \(accounts.responseData!.count + 1)"
        
             if let account = account {
            
                print(account.address.value)
                accounts.responseData!.append(Account(rawPrivateKey: account.privateKey, rawPublicKey: account.publicKey, privateKey: account.privateKey, address: account.address.value, accountName: accountName, canDelete: "YES"))
                    
                    let str = String(data: try! JSONEncoder().encode(accounts), encoding: .utf8)
                    print(str as Any)
                    
                    UserDefaultsManager.shared.updateWalletData(address: account.address.value, privateKey: account.privateKey, rawPublicKey: account.publicKey)
                    
                    self.saveAccount(data: (str!))
                
             }
            
     }
    
        

    
}



extension DataBaseManager {
    
    
    func deleteAccount(selectedIndex:Int) {
        
        let savedAccounts = geAccountJSON()

         let dataJson = savedAccounts.data(using: .utf8)!

            var accounts = try! JSONDecoder().decode(AllAccounts.self, from: dataJson)
         
            accounts.responseData?.remove(at: selectedIndex)
           
            let str = String(data: try! JSONEncoder().encode(accounts), encoding: .utf8)
            print(str as Any)
            
            let account = accounts.responseData!.first // defaultAccount
            
            // Replace old account with default account
        
           UserDefaultsManager.shared.updateWalletData(address: account!.address, privateKey: account!.rawPrivateKey, rawPublicKey: account!.rawPublicKey)
            
            self.saveAccount(data: (str!))
            
        }
        
}

extension DataBaseManager {
    
    
    func deleteNetwork(selectedIndex:Int) {
        
        let savedNetworks = geNetworkJSON()

         let dataJson = savedNetworks.data(using: .utf8)!

            var networks = try! JSONDecoder().decode(AllNetworks.self, from: dataJson)
         
            networks.responseData?.remove(at: selectedIndex)
           
            let str = String(data: try! JSONEncoder().encode(networks), encoding: .utf8)
            print(str as Any)
            
        self.saveNetwork(data: str!)
        
          //  let network = networks.responseData!.first // default Network
    
            
        }
        
}
    
 


extension DataBaseManager {
    
func addDefaultNetworks () {
    
    if DataBaseManager.shared.getNetworks().isEmpty{
      
              DataBaseManager.shared.addNetwork(name: "XDC Apothem Testnet", rpc: "https://apothemxdcpayrpc.blocksscan.io/", id: "51", symbol: "XDC", url: "http://faucet.apothem.network/", isEditable: "No")
       
              DataBaseManager.shared.addNetwork(name: "XDC Mainnet", rpc: "https://xdcpayrpc.blocksscan.io/", id: "50", symbol: "XDC", url: "https://observer.xdc.org", isEditable: "No")
        
              DataBaseManager.shared.addNetwork(name: "Localhost 8545", rpc: "https://localhost:8545", id: "", symbol: "", url: "", isEditable: "No")
        
        UserDefaultsManager.shared.setOrUpdateCurrentNetworkRpc(url:  DataBaseManager.shared.getNetworks().first?.rpc ?? "")
              UserDefaultsManager.shared.setOrUpdateCurrentNetworkName(name: DataBaseManager.shared.getNetworks().first?.name ?? "")
      
    }
  }
    
}
