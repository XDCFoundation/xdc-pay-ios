//
//  Animations.swift
//  DemoDrawer
//
//  Created by HSM3 on 17/01/18.
//  Copyright © 2018 HSM3. All rights reserved.
//

import UIKit


func flipTransition (with view1: UIView, view2: UIView, isReverse: Bool = false) {
    var transitionOptions = UIView.AnimationOptions()
    transitionOptions = isReverse ? [.transitionFlipFromLeft] : [.transitionFlipFromRight] // options for transition
    
    // animation durations are equal so while first will finish, second will start
    // below example could be done also using completion block.
    
    UIView.transition(with: view1, duration: 1.3, options: transitionOptions, animations: {
        view1.isHidden = false
    })
    
    UIView.transition(with: view2, duration: 1.3, options: transitionOptions, animations: {
        view2.isHidden = true
    })
}


extension UIView
    
{
    func slideLeft()
    {
        
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.layer.add(transition, forKey: kCATransition)
    }
    
    
    
    func slideRight()
    {
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.layer.add(transition, forKey: kCATransition)
        
        
    }
}


