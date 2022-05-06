//
//  InfoHelpVC.swift
//  XDCPay
//
//  Created by Admin on 07/04/22.
//

import UIKit


class InfoHelpVC : UIViewController {
    
    @IBOutlet weak var contentLbl: UILabel!
    
    
    override func viewDidLoad() {        
        let version = version()
        self.contentLbl.text = "XDCPay Version \n" + "\(version) (Beta)" + "\n\n" + Constants.infoHelpStr
    }
    
    func version() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
//        let build = dictionary["CFBundleVersion"] as! String
//        return "\(version) build \(build)"
        return "\(version)"
    }
    
    @IBAction func privacyPolicyBtnAction(_ sender: UIButton) {
        let viewController = UIStoryboard(name: "Storyboard3", bundle: nil).instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        viewController.pageLink = Constants.privacyPolicyUrl
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func visitOurWebsiteBtnAction(_ sender: UIButton) {
        let viewController = UIStoryboard(name: "Storyboard3", bundle: nil).instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        viewController.pageLink = Constants.visitOurWebsiteUrl
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func contactUsBtnAction(_ sender: UIButton) {
        let viewController = UIStoryboard(name: "Storyboard3", bundle: nil).instantiateViewController(withIdentifier: "HelpViewController") as! HelpViewController
        viewController.pageLink = Constants.contactUsUrl
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    
}
