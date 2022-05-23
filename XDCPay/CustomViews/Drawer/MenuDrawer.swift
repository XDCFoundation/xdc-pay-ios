//
//  MenuDrawer.swift
//  DemoDrawer
//
//  Created by HSM3 on 17/01/18.
//  Copyright © 2018 HSM3. All rights reserved.

import UIKit

let menuDrawer = MenuDrawer().loadNib() as! MenuDrawer

var delegateMenuDrawer :MenuDrawerProtocol?
protocol MenuDrawerProtocol {
    func onSelectRow(row:Int)
    func onAccount()
    func onEditAccountName()
}



class MenuDrawer: UIView , UITableViewDelegate , UITableViewDataSource {
    var panGesture : UIPanGestureRecognizer!
    @IBOutlet weak var blockerView: UIView!
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var accountName: UILabel!
    var items =  [String]()
    var images =  [String]()
    
    override func awakeFromNib() {
       self.setupViews()
    }
    
    @IBAction func onEdit(_ sender: Any) {
        
        self.hideDrawer()
        delegateMenuDrawer?.onEditAccountName()
    }
    
    @IBAction func onAccount(_ sender: Any) {
        self.hideDrawer()
        delegateMenuDrawer?.onAccount()
    }
    
    
    func initialize(view:UIView){
        
        self.frame = view.frame
         let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
         swipeRight.direction = UISwipeGestureRecognizer.Direction.right
         view.addGestureRecognizer(swipeRight)

    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
               // showHideDrawer()
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
  
    func showHideDrawer() {
        
        self.accountName.text = DataBaseManager.shared.getCurrentAccountName()
     
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            if !menuDrawer.isDescendant(of:  topController.view) {
                
                  topController.view.addSubview(menuDrawer)
                  menuDrawer.slideLeft()
            }
            if(menuDrawer.isHidden) {
                menuDrawer.isHidden = false
                menuDrawer.slideLeft()
            }
            
        }
        
    }
 
}


extension MenuDrawer {
   
    func setupViews() {
      
        self.accountName.text = DataBaseManager.shared.getCurrentAccountName()
        
        self.tableView.register(UINib(nibName: "MenuDrawerCellTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuDrawerCellTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        // Add Tap Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        blockerView.addGestureRecognizer(tap)
        blockerView.isUserInteractionEnabled = true
        
        
        // Add Swipe
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.blockerViewLeftGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        blockerView.addGestureRecognizer(swipeLeft)
        
    }
    
    @objc func blockerViewLeftGesture() {
          self.hideDrawer()
    }
    func setTableViewData(data:[String], images:[String]) {
        self.items = data
        self.images = images
        self.tableView.reloadData()
    }
    
   @objc func handleTap(_ sender: UITapGestureRecognizer) {
     self.hideDrawer()
    }
    func hideDrawer() {
         menuDrawer.slideRight()
         self.isHidden = true
    }
    
    
    
    
}

extension MenuDrawer {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MenuDrawerCellTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "MenuDrawerCellTableViewCell", for: indexPath) as! MenuDrawerCellTableViewCell
        cell.labelTitle.text = items[indexPath.row]
        cell.icons.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.hideDrawer()
         }
        
        
         delegateMenuDrawer?.onSelectRow(row: indexPath.row)
    }
    
    
}

class CustomUITextField: UITextField {
   override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
   }
}
