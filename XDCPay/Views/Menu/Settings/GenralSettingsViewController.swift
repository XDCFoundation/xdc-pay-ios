//
//  GenralSettingsViewController.swift
//  XDCPay
//
//  Created by Admin on 30/03/22.
//

import UIKit

class GenralSettingsViewController: UIViewController {
    
    @IBOutlet weak var currencyUpdate: UILabel!
    
    @IBOutlet weak var languageUpdate: UILabel!
    
    //    var currencyArray = ["USD" , "INR" , "EUR" , "RUB" , "SNT", "SGD- Singapore Dollar" , "SAI- SAI"]
    var currencyArray = ["USD- United State Dollar"]
    
//    var languageArray = ["Hindi" , "English" , "Spanish" , "Russian" , "Korean" , "Portugal- Brazil" , "Japanese"]
    var languageArray = ["English"]
    
    override func viewDidLoad() {
      
        self.currencyUpdate.text = "Updated " +  UserDefaultsManager.shared.currencyUpdateTime()
        self.languageUpdate.text = "Updated " +  UserDefaultsManager.shared.languageUpdateTime()
    }

    @IBAction func onCurrency(_ sender: Any) {
        
        let picker = self.storyboard?.instantiateViewController(withIdentifier: "CommanSettingsPicker") as! CommanSettingsPicker
        picker.data = self.currencyArray
        picker.titleName = "Base Currency"
        self.present(picker, animated: true, completion: nil)
        picker.completionHandler = { selectedRow in
             UserDefaultsManager.shared.setCurrencyUpdateTime()
             self.currencyUpdate.text = "Updated " +  UserDefaultsManager.shared.currencyUpdateTime()
                              
        }
        
    }
    
    
    @IBAction func onLanguage(_ sender: Any) {
        
        let picker = self.storyboard?.instantiateViewController(withIdentifier: "CommanSettingsPicker") as! CommanSettingsPicker
        picker.data = self.languageArray
        picker.titleName = "Current Language"
        self.present(picker, animated: true, completion: nil)
        picker.completionHandler = { selectedRow in
            UserDefaultsManager.shared.setLanguageUpdateTime()
            self.languageUpdate.text = "Updated " +  UserDefaultsManager.shared.languageUpdateTime()
        }
        
        
    }

        
    
    
}
