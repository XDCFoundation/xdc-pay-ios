 
 
import UIKit

class TransactionViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var networkName: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var transactions = [Transaction]()
    
    override func viewDidLoad() {
         
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.transactions = DataBaseManager.shared.getTransactions()
        
        self.tableView.register(UINib(nibName: "TransactionCell", bundle: nil), forCellReuseIdentifier: "TransactionCell")
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let transction = self.transactions[indexPath.row]
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        
        cell.transactionHash.text = transction.recipientAddress
        cell.symbol.text = "XDC"
        cell.amount.text =  transction.amount
        cell.time.text = transction.time
        
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
    }
}
