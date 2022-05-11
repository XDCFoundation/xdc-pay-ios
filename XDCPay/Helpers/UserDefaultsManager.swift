//
//  UserDefaultsManager.swift
//  XDCPay
//
//  Created by Admin on 11/04/22.
//

import Foundation

class UserDefaultsManager  {
    
     static  let shared =  UserDefaultsManager()
    
    func setOrUpdateCurrentNetworkName(name:String) {
        UserDefaults.standard.setValue(name, forKey: "currentNetworkName")
    }
    func resetAccount() {
         UserDefaults.standard.setValue("", forKey: "transaction")
    }
    
    func getCurrentNetworkRpc() ->String {
        return UserDefaults.standard.value(forKey: "currentNetwork") as! String
    }
    
    func setCurrencyUpdateTime() {
        UserDefaults.standard.setValue(getDateString(style: .long), forKey: "CurrencyUpdateTime")
    }
    
    func setLanguageUpdateTime() {
        UserDefaults.standard.setValue(getDateString(style: .long), forKey: "LanguageUpdateTime")
    }
    
    func currencyUpdateTime() ->String {
        return UserDefaults.standard.value(forKey: "CurrencyUpdateTime") as! String
    }
    func languageUpdateTime() ->String {
        return UserDefaults.standard.value(forKey: "LanguageUpdateTime") as! String
    }
    
    
    func setOrUpdateCurrentNetworkRpc(url:String) {
        UserDefaults.standard.setValue(url, forKey: "currentNetwork")
    }
    
    func getCurrentNetworName() ->String {
        
        return UserDefaults.standard.value(forKey: "currentNetworkName") as! String
        
    }

    
    func  updateWalletData(address:String,privateKey:String,rawPublicKey:String) {
        
        var walletData = UserDefaults.standard.array(forKey: "WalletData") ?? []
      
        walletData[0] = address
        walletData[1] = privateKey
        walletData[3] = rawPublicKey
        
        UserDefaults.standard.setValue(walletData, forKey: "WalletData")

    }
    
     
    func clearUserDefaults() {
        
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()

            dictionary.keys.forEach
            { key in   defaults.removeObject(forKey: key)
            }
    }
    
    func getCurrentAccoutWalletAddress()->String {
        
        let walletData = UserDefaults.standard.array(forKey: "WalletData") ?? []
        
        if(walletData.count > 0) {
            guard var walletAddress = walletData[0] as? String else {
                return ""
            }
            
            walletAddress.removeFirst()
            walletAddress.removeFirst()
            
            
            return "xdc" + walletAddress
        }else {
            return ""
        }
       
    }
    
    
    
    
    func isLoggedIn() -> Bool{
        
        let walletData = UserDefaults.standard.array(forKey: "WalletData") ?? []
        
        if(walletData.count > 0) {
            return true
        }else {
           return false
        }
      
    }
    
    func logOut() {
        UserDefaults.standard.setValue(true, forKey: "logOut")
    }
    
    func getWalletAddress()->String {
        
        let walletData = UserDefaults.standard.array(forKey: "WalletData") ?? []
        
        if(walletData.count > 0) {
            guard let walletAddress = walletData[0] as? String else {
                return ""
            }
            return walletAddress
        }else {
            return ""
        }
        
//        guard let privateKey = walletData![1] as? String else {
//            return
//        }
       
    }
    
    
    func getCurrentWalletAddress0x()->String {
        
        let walletData = UserDefaults.standard.array(forKey: "WalletData") ?? []
        
        if(walletData.count > 0) {
            guard var walletAddress = walletData[0] as? String else {
                return ""
            }
            
            walletAddress.removeFirst()
            walletAddress.removeFirst()
            
            
            return "0x" + walletAddress
        }else {
            return ""
        }
    
    }
    
    
    func getMainWalletAddress()->String {
        
        let walletData = UserDefaults.standard.array(forKey: "WalletData") ?? []
        
        if(walletData.count > 0) {
            guard var walletAddress = walletData[0] as? String else {
                return ""
            }
            
            walletAddress.removeFirst()
            walletAddress.removeFirst()
            
            
            return "xdc" + walletAddress
        }else {
            return ""
        }
        
//        guard let privateKey = walletData![1] as? String else {
//            return
//        }
       
    }
    
}
