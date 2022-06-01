//
//  ImportAccountViewController.swift
//  XDCPay
//
//  Created by Admin on 04/04/22.
//

import UIKit
import XDC3Swift


class ImportAccountViewController: UIViewController {
    
    @IBOutlet weak var privateKey: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onImport(_ sender: Any) {
 
        if privateKey.text.count > 0 && privateKey.text != "eg. ce4085d87dc63992e358f5c1a8bd4c4de647b b0cfdec034d00c3c9532535f324" {
            self.LoadingStart()
            
            DataBaseManager.shared.importAccount(rowPrivateKey: self.privateKey.text!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.LoadingStop()
                SceneDelegate.shared?.checkLogin()
            }
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "Cannot import an empty key", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}

// MARK: - UITextViewDelegate Extension

extension ImportAccountViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "eg. ce4085d87dc63992e358f5c1a8bd4c4de647b b0cfdec034d00c3c9532535f324" {
            textView.text = nil
            textView.textColor = AppColors.textColor.color()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "eg. ce4085d87dc63992e358f5c1a8bd4c4de647b b0cfdec034d00c3c9532535f324"
            textView.textColor = AppColors.placeholderColor.color()
        }
    }
    
}
