 
import UIKit

class CommanSettingsPicker: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titlePicker: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var tableContainer: UIView!
    @IBOutlet weak var tableContainerHHeight: NSLayoutConstraint!
    var completionHandler:((Int) -> Void)?
    var cellHeight:CGFloat = 60.0
    var titleName = ""
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleView.clipsToBounds = true
        self.titleView.layer.cornerRadius = 10
        self.titleView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.tableView.register(UINib(nibName: "CommanListCell", bundle: nil), forCellReuseIdentifier: "CommanListCell")
        self.handelTableHeight()
        self.tableView.reloadData()
        self.titlePicker.text = titleName
        
    }
    
    
    func handelTableHeight()  {
         
        self.tableView.isScrollEnabled = false
        
        if(data.count == 1) {
            self.tableContainerHHeight.constant = 100
        }
        
        if(data.count == 2) {
            self.tableContainerHHeight.constant = 150
        }
        
        if(data.count == 3) {
            self.tableContainerHHeight.constant = 200
        }
        
        if(data.count == 4) {
            self.tableContainerHHeight.constant = 200 + 10
        }
        
        if(data.count == 5) {
            self.tableContainerHHeight.constant = 200 + cellHeight
        }
        
        if(data.count == 6) {
            self.tableContainerHHeight.constant = 200 + cellHeight * 2
        }
        
        if(data.count >  6) {
            self.tableContainerHHeight.constant = 200 + cellHeight * 2
            self.tableView.isScrollEnabled = true
        }
        
    }
 
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         completionHandler?(indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CommanListCell") as! CommanListCell
        cell.titleName.text = self.data[indexPath.row]
 
        return cell
        
    }
    

}
