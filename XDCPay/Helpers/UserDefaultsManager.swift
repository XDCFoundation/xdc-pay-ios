//
//  UserDefaultsManager.swift
//  XDCPay
//
//  Created by Admin on 11/04/22.
//

import Foundation

class UserDefaultsManager  {
    
    
    static  let shared =  UserDefaultsManager()
    
    
    func clearUserDefaults() {
        
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()

            dictionary.keys.forEach
            { key in   defaults.removeObject(forKey: key)
            }
    }
    
    func getCurrentNetworkWalletAddress()->String {
        
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