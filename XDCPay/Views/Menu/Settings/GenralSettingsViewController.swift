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
    var currencyArray = ["USD"]
    
//    var languageArray = ["Hindi" , "English" , "Spanish" , "Russian" , "Korean" , "Portugal- Brazil" , "Japanese"]
    var languageArray = ["English"]
    
    override func viewDidLoad() {
      
        self.currencyUpdate.text = "Updated " +  UserDefaultsManager.shared.currencyUpdateTime()
        self.languageUpdate.text = "Updated " +  UserDefaultsManager.shared.languageUpdateTime()
    }

    @IBAction func onCurrency(_ sender: Any) {
        
        let pickerViewClass = self.storyboard?.instantiateViewController(withIdentifier: "PickerViewClass") as! PickerViewClass
                       pickerViewClass.pickerData = self.currencyArray
        pickerViewClass.titleName = "Current Language"
                            self.present(pickerViewClass, animated: true, completion: nil)
                           pickerViewClass.completionHandler = { selectedRow in
                            UserDefaultsManager.shared.setCurrencyUpdateTime()
                            self.currencyUpdate.text = "Updated " +  UserDefaultsManager.shared.currencyUpdateTime()
                              // self.positionButton.setTitle( self.positionArray[selectedRow], for: .normal)
                              // self.selectedIndex = selectedRow
                              
        }
        
    }
    
    
    @IBAction func onLanguage(_ sender: Any) {
        
        let pickerViewClass = self.storyboard?.instantiateViewController(withIdentifier: "PickerViewClass") as! PickerViewClass
                       pickerViewClass.pickerData = self.languageArray
        pickerViewClass.titleName = "Base Currency"
                            self.present(pickerViewClass, animated: true, completion: nil)
                            pickerViewClass.completionHandler = { selectedRow in
                            UserDefaultsManager.shared.setLanguageUpdateTime()
                            self.languageUpdate.text = "Updated " +  UserDefaultsManager.shared.languageUpdateTime()
                          
                              // self.positionButton.setTitle( self.positionArray[selectedRow], for: .normal)
                              // self.selectedIndex = selectedRow
                              
        }
        
    }

        
    
    
}
