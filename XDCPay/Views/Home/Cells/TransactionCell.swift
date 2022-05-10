//
//  TransactionCell.swift
//  XDCPay
//
//  Created by Admin on 29/03/22.
//

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var sendReceiveImage: UIImageView!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var symbol: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    @IBOutlet weak var transactionHash: UILabel!
    @IBOutlet weak var time: UILabel!
    
}
