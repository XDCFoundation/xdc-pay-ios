//
//  TestViewController.swift
//  ViewPager-Swift
//
//  Created by Nishan Niraula on 4/13/19.
//  Copyright © 2019 Nishan. All rights reserved.
//

import UIKit

class ViewPagerTabContainer: UIViewController {

    var tabs = [ViewPagerTab]()
    var options: ViewPagerOptions?
    var pager:ViewPager?
    
    var index = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabs =  [
            ViewPagerTab(title: "Transactions", image: UIImage(named: "Transactions")),
            ViewPagerTab(title: "Tokens", image: UIImage(named: "Tokens")),
        ]
        options = ViewPagerOptions()
        options?.tabViewBackgroundDefaultColor = .white
        options?.tabViewBackgroundHighlightColor = .white
        options?.tabIndicatorViewBackgroundColor = UIColor.init(hexString: "#2049B9")
        options?.tabViewTextDefaultColor = UIColor.init(hexString: "#848484")
        options?.tabViewTextHighlightColor = UIColor.init(hexString: "#2149B9")
        options?.tabViewTextFont = UIFont.systemFont(ofSize: 14, weight: .medium)

        options?.tabType = .basic
        options?.distribution = .segmented
        pager = ViewPager(viewController: self)
        guard let options = self.options else { return }
        pager?.setOptions(options: options)
        pager?.setDataSource(dataSource: self)
        pager?.setDelegate(delegate: self)
        pager?.build()
        
    }
    
    
    deinit {
        print("Memory Deallocation")
    }
}

extension ViewPagerTabContainer : ViewPagerDataSource {
    
    func numberOfPages() -> Int {
        return tabs.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController {
        
        switch position {
        
        case position:
       
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewPagerItemViewController") as! ViewPagerItemViewController
            vc.position = position
           
            return vc
            
        default:
            return UIViewController()
        }
         
      
    }
    
    func tabsForPages() -> [ViewPagerTab] {
        return tabs
    }
    
    func startViewPagerAtIndex() -> Int {
        return 0
    }
}

extension ViewPagerTabContainer: ViewPagerDelegate {
    
     
    
    func willMoveToControllerAtIndex(index:Int) {
        print("Moving to page \(index)")
    }
    
    func didMoveToControllerAtIndex(index: Int) {
        print("Moved to page \(index)")
        
    }
}
