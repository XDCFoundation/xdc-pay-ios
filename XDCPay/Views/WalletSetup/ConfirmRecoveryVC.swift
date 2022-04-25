import UIKit

import Foundation

class ConfirmRecoveryVC: UIViewController , UITextFieldDelegate{

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

        print(seedArray)
        indexs = getIndexAndValues()
        print(indexs)

        self.word1Title.text = "Word \(indexs[0])"

        self.word2Title.text = "Word \(indexs[1])"

        self.word3Title.text = "Word \(indexs[2])"

    }
    func getIndexAndValues() ->([Int]) {
        
        let randomArray =  self.seedArray.pickUniqueInValue(3)

        print(randomArray)

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

        print(fWord)

        print(sWord)

        print(tWord)

        if(fWord == seedArray[indexs[0] - 1]) {

            print("first word is ok")

            self.firstTick.isHidden = false

        }else {

            self.firstTick.isHidden = true

        }

        

        if(sWord == seedArray[indexs[1] - 1]) {

            print("second word is ok")

            self.secondTick.isHidden = false

        }else {

            self.secondTick.isHidden = true

        }

        

        if(tWord == seedArray[indexs[2] - 1]) {

            self.thirdTick.isHidden = false

            print("third word is ok")

        }else {

            self.thirdTick.isHidden = true

        }

        if(!firstTick.isHidden && !secondTick.isHidden && !thirdTick.isHidden ) {

            

            UserDefaults.standard.setValue(accountData, forKey: "WalletData")

            UserDefaults.standard.setValue(seedPhrase, forKey: "seed")

            let vc = UIStoryboard(name: "Storyboard2", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController

                vc.modalPresentationStyle = .fullScreen
               self.present(vc, animated: true, completion: nil)

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
