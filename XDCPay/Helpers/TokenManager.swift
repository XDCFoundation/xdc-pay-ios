//
//  TokenManager.swift
//  XDCPay
//
//  Created by Angshuman Das on 02/03/1401 AP.
//

import XDC3Swift
import Foundation

 class TokenManager {
     
     typealias SuccessCompletion = (String?) -> Void
     typealias ErrorCompletion = (String?) -> Void
    
     static var shared = TokenManager()
    
     var client: XDCClient? = XDCClientManager.shared.getXDCClient()
     var TokenContract: XRC20?
     
     
     init() {
         self.TokenContract = XRC20(client: client!)
     }
    
     func _symbolXRC20(_contractAddress: String, onSuccess: @escaping SuccessCompletion, onError: @escaping ErrorCompletion) {
         TokenContract?.symbol(tokenContract: XDCAddress(_contractAddress), completion: { (error, symbol) in
             if error != nil {
                 onError(error.debugDescription)
             }else {
                 onSuccess(symbol)
             }
         })
     }
     
     
     func _decimalXRC20(_contractAddress: String, onSuccess: @escaping SuccessCompletion, onError: @escaping ErrorCompletion) {
         TokenContract?.decimals(tokenContract: XDCAddress(_contractAddress), completion: { (error, decimal) in
             if error != nil {
                 onError(error.debugDescription)
             }else {
                 onSuccess(String(describing: decimal!))
             }
         })
     }
    
     func _balanceToken(_contractAddress: String, onSuccess: @escaping SuccessCompletion, onError: @escaping ErrorCompletion) {
         TokenContract?.balanceOf(tokenContract: XDCAddress(_contractAddress), account: XDCAddress(UserDefaultsManager.shared.getCurrentWalletAddress0x()), completion: { error, balance in
             if error != nil {
                 onError(error.debugDescription)
             }else {
                 onSuccess(String(describing: balance!))
             }
         })
     }
 }

