//
//  HelpViewController.swift
//  XDCPay
//
//  Created by prashant on 02/05/22.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {

    var pageLink: String?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadHelp()
    }
    

    func loadHelp() {
        if let pageLink = pageLink, let url = URL(string: pageLink), UIApplication.shared.canOpenURL(url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

}
