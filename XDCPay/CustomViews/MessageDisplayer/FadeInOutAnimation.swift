//
//  This source file is part of the SSENSE project
//  Babypass
//
//  Created by iOS Developer on 2021-08-29.
//

import SwiftMessages
import UIKit

public class FadeInOutAnimation: NSObject, Animator {
    // Following Animator protocol:
    public var showDuration: TimeInterval = 0.3
    public var hideDuration: TimeInterval = 0.3

    public weak var delegate: AnimationDelegate?
    weak var messageView: UIView?
    weak var containerView: UIView?
    var context: AnimationContext?

    var bottomAnchorConstant: CGFloat = 0.0

    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.adjustMargins), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    public func show(context: AnimationContext, completion: @escaping AnimationCompletion) {
        self.install(context: context)
        self.showAnimation(context: context, completion: completion)
    }

    public func hide(context: AnimationContext, completion: @escaping AnimationCompletion) {
        let view = context.messageView
        self.context = context
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            view.alpha = 1.0
            completion(true)
        }
        UIView.animate(withDuration: self.hideDuration, delay: 0, options: [.beginFromCurrentState, .curveEaseInOut, .allowUserInteraction], animations: {
            view.alpha = 0
        }, completion: nil)
        CATransaction.commit()
    }

    func showAnimation(context: AnimationContext, completion: @escaping AnimationCompletion) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion(true)
        }
        let view = context.messageView
        view.alpha = 0
        UIView.animate(withDuration: self.showDuration, delay: 0, options: [.beginFromCurrentState, .curveEaseInOut, .allowUserInteraction], animations: {
            view.alpha = 1.0
        }, completion: nil)
        CATransaction.commit()
    }

    func install(context: AnimationContext) {
        let view = context.messageView
        let container = context.containerView
        self.messageView = view
        self.containerView = container
        self.context = context

        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)

        view.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true

        // Where to move the notification
        if self.bottomAnchorConstant == 0.0 {
            // Default position to center
            view.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        } else {
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -self.bottomAnchorConstant).isActive = true
        }

        // Important to layout now in order to get the right safe area insets
        container.layoutIfNeeded()
        self.adjustMargins()
        container.layoutIfNeeded()
    }

    @objc public func adjustMargins() {
        guard let adjustable = messageView as? MarginAdjustable & UIView,
              let context = context else { return }
        adjustable.preservesSuperviewLayoutMargins = false
        if #available(iOS 11, *) {
            adjustable.insetsLayoutMarginsFromSafeArea = false
        }
        adjustable.layoutMargins = adjustable.defaultMarginAdjustment(context: context)
    }
}
