//
//  GenralSettingsViewController.swift
//  XDCPay
//
//  Created by Admin on 30/03/22.
//

import UIKit

class GenralSettingsViewController: UIViewController {
    
    var currencyArray = ["USD" , "INR" , "EUR" , "RUB" , "SNT", "SGD- Singapore Dollar" , "SAI- SAI"]
    
    var languageArray = ["Hindi" , "English" , "Spanish" , "Russian" , "Korean" , "Portugal- Brazil" , "Japanese"]
    

    @IBAction func onCurrency(_ sender: Any) {
        
        let pickerViewClass = self.storyboard?.instantiateViewController(withIdentifier: "PickerViewClass") as! PickerViewClass
                       pickerViewClass.pickerData = self.currencyArray
        pickerViewClass.titleName = "Current Language"
                            self.present(pickerViewClass, animated: true, completion: nil)
                           pickerViewClass.completionHandler = { selectedRow in
                              // self.positionButton.setTitle( self.positionArray[selectedRow], for: .normal)
                              // self.selectedIndex = selectedRow
                               return  50
        }
        
    }
    
    
    @IBAction func onLanguage(_ sender: Any) {
        
        let pickerViewClass = self.storyboard?.instantiateViewController(withIdentifier: "PickerViewClass") as! PickerViewClass
                       pickerViewClass.pickerData = self.languageArray
        pickerViewClass.titleName = "Base Currency"
                            self.present(pickerViewClass, animated: true, completion: nil)
                           pickerViewClass.completionHandler = { selectedRow in
                              // self.positionButton.setTitle( self.positionArray[selectedRow], for: .normal)
                              // self.selectedIndex = selectedRow
                               return  50
        }
        
    }

        
    
    
}
