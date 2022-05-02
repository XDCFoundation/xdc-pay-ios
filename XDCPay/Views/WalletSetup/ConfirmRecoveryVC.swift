import UIKit
import Foundation

class ConfirmRecoveryVC: UIViewController {
    
    var seedArray =  [String]()
    var accountData = [String]()
    var seedPhrase = ""
   
    @IBOutlet weak var thirdTick: UIImageView!
    @IBOutlet weak var secondTick: UIImageView!
    @IBOutlet weak var firstTick: UIImageView!
    @IBOutlet weak var word1Title: UILabel!
    @IBOutlet weak var word1TextField: UITextField!
    @IBOutlet weak var word2Title: UILabel!
    
    @IBOutlet weak var word2TextField: UITextField!
    
    @IBOutlet weak var word3Title: UILabel!
    
    @IBOutlet weak var word3TextField: UITextField!
    
   
    var indexs = [Int]()
     
    override func viewDidLoad() {
    
        self.word1TextField.delegate = self
        self.word2TextField.delegate = self
        self.word3TextField.delegate = self
        
        indexs = getIndexAndValues()
       
        self.word1Title.text = "Word \(indexs[0])"
        self.word2Title.text = "Word \(indexs[1])"
        self.word3Title.text = "Word \(indexs[2])"
        

        
    }
    
    func getIndexAndValues() ->([Int]) {
        
        let randomArray =  self.seedArray.pickUniqueInValue(3)
        
        let firstIndex = seedArray.firstIndex(of: randomArray[0])! + 1
        let secondIndex = seedArray.firstIndex(of: randomArray[1])! + 1
        let thirdIndex = seedArray.firstIndex(of: randomArray[2])! + 1
    
        var temp = [firstIndex,secondIndex,thirdIndex]
        temp.sort()
        return (temp)
    }
    
    
    
    @IBAction func onConfirmRecovery(_ sender: Any) {
        
        let fWord = word1TextField.text!
        let sWord = word2TextField.text!
        let tWord = word3TextField.text!
        
        if(fWord == seedArray[indexs[0] - 1]) {
            self.firstTick.isHidden = false
        }else {
            self.firstTick.isHidden = true
        }
        
        if(sWord == seedArray[indexs[1] - 1]) {
            self.secondTick.isHidden = false
        }else {
            self.secondTick.isHidden = true
        }
        
        if(tWord == seedArray[indexs[2] - 1]) {
            self.thirdTick.isHidden = false
        }else {
            self.thirdTick.isHidden = true
        }
        
        
        if(!firstTick.isHidden && !secondTick.isHidden && !thirdTick.isHidden ) {
            
            UserDefaultsManager.shared.clearUserDefaults()
            
            UserDefaults.standard.setValue(accountData, forKey: "WalletData")
            UserDefaults.standard.setValue(seedPhrase, forKey: "seed")
           
            DataBaseManager.shared.saveDefaultAccount(address: self.accountData[0], privateKey: self.accountData[1], publicKey: self.accountData[3])
            
            let vc = UIStoryboard(name: "Storyboard2", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                vc.modalPresentationStyle = .fullScreen
               
            
                self.present(vc, animated: true, completion: nil)
            
        }
        
        
    }
    
}
extension ConfirmRecoveryVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == self.word1TextField) {
            if self.word1TextField.text == seedArray[indexs[0] - 1] {
                self.firstTick.isHidden = false
            } else {
                self.firstTick.isHidden = true
            }
            
        } else if (textField == self.word2TextField) {
            if self.word2TextField.text == seedArray[indexs[1] - 1] {
                self.secondTick.isHidden = false
            } else {
                self.secondTick.isHidden = true
            }
            
        } else if (textField == self.word3TextField) {
            if self.word3TextField.text == seedArray[indexs[2] - 1] {
                self.thirdTick.isHidden = false
            } else {
                self.thirdTick.isHidden = true
            }
        }
    }
}

extension Array where Element: Hashable {
    
    func pickUniqueInValue(_ n: Int) -> [Element] {
        let set: Set<Element> = Set(self)
        guard set.count >= n else {
            fatalError("The array has to have at least \(n) unique values")
        }
        guard n >= 0 else {
            fatalError("The number of elements to be picked must be positive")
        }

        return Array(set.prefix(upTo: set.index(set.startIndex, offsetBy: n)))
    }
}
