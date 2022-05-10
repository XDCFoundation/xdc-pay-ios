//
//  ReceiveViewController.swift
//  XDCPay
//
//  Created by Admin on 11/04/22.
//

import UIKit

class ReceiveViewController: UIViewController {
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var walletName: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var walletAddress: UILabel!
     
    
    override func viewDidLoad() {
        self.walletAddress.text = UserDefaultsManager.shared.getMainWalletAddress()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        let qrCode  =  QRCode(string: UserDefaultsManager.shared.getMainWalletAddress(), color: UIColor.black, backgroundColor: UIColor.white, size: CGSize(width: 100, height: 100), scale: 1.0, inputCorrection: .medium)
        
        self.qrImageView.image = try! qrCode?.image()
    }
    
    @IBAction func onCopy(_ sender: Any) {
        UIPasteboard.general.string =  self.walletAddress.text!
        self.showCopyToast()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
