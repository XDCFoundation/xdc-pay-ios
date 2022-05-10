

import UIKit

class SeedWordsViewController: UIViewController {
    
    var seedArray : [String]?
    
    @IBOutlet var seedWord1: UILabel!
    @IBOutlet var seedWord2: UILabel!
    @IBOutlet var seedWord3: UILabel!
    
    @IBOutlet var seedWord4: UILabel!
    @IBOutlet var seedWord5: UILabel!
    @IBOutlet var seedWord6: UILabel!
    
    @IBOutlet var seedWord7: UILabel!
    @IBOutlet var seedWord8: UILabel!
    @IBOutlet var seedWord9: UILabel!
    
    @IBOutlet var seedWord10: UILabel!
    @IBOutlet var seedWord11: UILabel!
    @IBOutlet var seedWord12: UILabel!
    
    let yourAttributes: [NSAttributedString.Key: Any] = [
          .underlineStyle: NSUnderlineStyle.single.rawValue
      ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
       
        seedArray =  "\(UserDefaults.standard.value(forKey: "seed") ?? "")".components(separatedBy: " ")
        seedWord1.text = "1. \(seedArray![0])"
        seedWord2.text = "2. \(seedArray![1])"
        seedWord3.text = "3. \(seedArray![2])"
        seedWord4.text = "4. \(seedArray![3])"
        seedWord5.text = "5. \(seedArray![4])"
        seedWord6.text = "6. \(seedArray![5])"
        seedWord7.text = "7. \(seedArray![6])"
        seedWord8.text = "8. \(seedArray![7])"
        seedWord9.text = "9. \(seedArray![8])"
        seedWord10.text = "10. \(seedArray![9])"
        seedWord11.text = "11. \(seedArray![10])"
        seedWord12.text = "12. \(seedArray![11])"
        // Do any additional setup after loading the view.
    }
    

    func setup() {
        
    
        seedWord1.layer.borderWidth = 1
        seedWord1.layer.borderColor = UIColor(hexString: "#E6E6E6").cgColor
        seedWord1.layer.cornerRadius = 4
        
        seedWord2.layer.borderWidth = 1
        seedWord2.layer.borderColor = UIColor(hexString: "#E6E6E6").cgColor
        seedWord2.layer.cornerRadius = 4
        
        seedWord3.layer.borderWidth = 1
        seedWord3.layer.borderColor = UIColor(hexString: "#E6E6E6").cgColor
        seedWord3.layer.cornerRadius = 4
        
        seedWord4.layer.borderWidth = 1
        seedWord4.layer.borderColor = UIColor(hexString: "#E6E6E6").cgColor
        seedWord4.layer.cornerRadius = 4
        
        seedWord5.layer.borderWidth = 1
        seedWord5.layer.borderColor = UIColor(hexString: "#E6E6E6").cgColor
        seedWord5.layer.cornerRadius = 4
        
        seedWord6.layer.borderWidth = 1
        seedWord6.layer.borderColor = UIColor(hexString: "#E6E6E6").cgColor
        seedWord6.layer.cornerRadius = 4
        
        seedWord7.layer.borderWidth = 1
        seedWord7.layer.borderColor = UIColor(hexString: "#E6E6E6").cgColor
        seedWord7.layer.cornerRadius = 4
        
        seedWord8.layer.borderWidth = 1
        seedWord8.layer.borderColor = UIColor(hexString: "#E6E6E6").cgColor
        seedWord8.layer.cornerRadius = 4
        
        seedWord9.layer.borderWidth = 1
        seedWord9.layer.borderColor = UIColor(hexString: "#E6E6E6").cgColor
        seedWord9.layer.cornerRadius = 4
        
        seedWord10.layer.borderWidth = 1
        seedWord10.layer.borderColor = UIColor(hexString: "#E6E6E6").cgColor
        seedWord10.layer.cornerRadius = 4
        
        seedWord11.layer.borderWidth = 1
        seedWord11.layer.borderColor = UIColor(hexString: "#E6E6E6").cgColor
        seedWord11.layer.cornerRadius = 4
        
        seedWord12.layer.borderWidth = 1
        seedWord12.layer.borderColor = UIColor(hexString: "#E6E6E6").cgColor
        seedWord12.layer.cornerRadius = 4
        
        overrideUserInterfaceStyle = .light
    }
    
  
    
    @IBAction func onCopyToClipBoard(_ sender: Any) {
        self.showCopyToast()
        UIPasteboard.general.string = seedArray?.joined(separator: " ")
        
    }
    
}
