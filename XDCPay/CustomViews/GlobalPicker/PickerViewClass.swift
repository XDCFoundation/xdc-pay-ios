 
 import UIKit
 
 class PickerViewClass: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    var completionHandler:((Int) -> Int)?
    var titleName = ""
    
    @IBOutlet weak var pickerView: UIPickerView!
    var selectedRow = 0
    
    var pickerData = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        if(titleName.isEmpty) {
            self.titleLabel.text = "Please Select"
        }else  {
            self.titleLabel.text = titleName
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedRow = row
    }
    
    @IBAction func onDone(_ sender: Any) {
        
        print(selectedRow)
        
        let result = completionHandler?(selectedRow)
        print("completionHandler returns... \(String(describing: result))")
        self.dismiss(animated: true, completion: nil)
    }
    
 }

