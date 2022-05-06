//
//  MessageDisplayer.swift
//  Babypass
//
//  Created by iOS Developer on 2021-08-29.
//

import SwiftMessages
import UIKit

class MessageDisplayer {
    public static func hideMessage() {
        SwiftMessages.hide()
    }

    public static func showError(_ error: LocalizedError, _ didHide: (() -> Void)? = nil) {
        let view = MessageView.viewFromNib(layout: .messageView)

        view.configureTheme(.error)

        view.titleLabel?.isHidden = true
        view.iconImageView?.isHidden = true
        view.button?.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        view.button?.tintColor = AppColors.textForground.color()
        view.bodyLabel?.font = .boldSystemFont(ofSize: 14)
        view.backgroundColor? = AppColors.backkgroundDark.color()

        let errorMessage: String? = error.errorDescription
        if errorMessage == nil {
            log("MessageDisplayer | showError() | WARNING: Error message to show was nil for error. | error: \(String(describing: error))")
        }
        view.configureContent(title: nil, body: errorMessage, iconImage: nil, iconText: nil, buttonImage: UIImage(named: "Cancel"), buttonTitle: nil) { _ in
            SwiftMessages.hide()
        }

        view.layoutMarginAdditions = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)

        var config = SwiftMessages.Config()
        config.duration = .forever
        config.eventListeners.append { event in
            if case .didHide = event {
                didHide?()
            }
        }

        SwiftMessages.show(config: config, view: view)
    }

    public static func showMessage(message: String, duration: TimeInterval = 3.0, delay: TimeInterval = 0.0) {
        let view = MessageView.viewFromNib(layout: .messageView)

        view.configureTheme(.success)

        view.titleLabel?.isHidden = true
        view.iconImageView?.isHidden = true
        view.button?.isHidden = true
        view.button?.tintColor = AppColors.textForground.color()
        view.bodyLabel?.font = .boldSystemFont(ofSize: 14)
        view.bodyLabel?.textColor = AppColors.textForground.color()
        view.backgroundColor? = AppColors.backkgroundDark.color()
        view.configureContent(body: message)

        view.layoutMarginAdditions = UIEdgeInsets(top: 16, left: 10, bottom: 16, right: 10)

        var config = SwiftMessages.Config()
        config.duration = .seconds(seconds: duration)
        config.preferredStatusBarStyle = UIStatusBarStyle.lightContent

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            SwiftMessages.show(config: config, view: view)
        }
    }

    /** chore(MNA-4617): Jane's UX/UI Tweaks for Rami */
    public static func showErrorNew(_ view: MessageView, _ error: LocalizedError, _ shouldBeCustomPosition: Bool = false,
                                    _ customPosition: CGFloat = 0.0, _ didHide: (() -> Void)? = nil) {
        view.configureTheme(.error)

        view.titleLabel?.isHidden = true
        view.iconImageView?.isHidden = true
        view.button?.backgroundColor = UIColor.clear
        view.button?.titleLabel?.font = .boldSystemFont(ofSize: 14)
        view.button?.tintColor = AppColors.textForground.color()
        view.bodyLabel?.font = .boldSystemFont(ofSize: 16)
        view.backgroundColor? = AppColors.backkgroundDark.color()
        
        let errorMessage: String? = error.errorDescription
        let closeText = "BarButtonItem.closeTitle".localized().uppercased()
        if errorMessage == nil {
            log("MessageDisplayer | showErrorNew() | WARNING: Error message to show was nil for error. | error: \(String(describing: error))")
        }
        view.button?.titleLabel?.text = closeText
        view.configureContent(title: nil, body: errorMessage, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: closeText) { _ in
            SwiftMessages.hide()
        }

        view.layoutMarginAdditions = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 5)

        var config = SwiftMessages.Config()
        config.duration = .forever
        config.eventListeners.append { event in
            if case .didHide = event {
                didHide?()
            }
        }

        if shouldBeCustomPosition {
            let fadeInOutAnimation = FadeInOutAnimation()
            fadeInOutAnimation.bottomAnchorConstant = customPosition
            config.presentationStyle = .custom(animator: fadeInOutAnimation)
        }

        SwiftMessages.show(config: config, view: view)
    }

    /** chore(MNA-4617): Jane's UX/UI Tweaks for Rami */
    public static func showMessageNew(view: MessageView, message: String, timeLimit: TimeLimit,
                                      shouldBeCustomPosition: Bool = false, customPosition: CGFloat = 0.0,
                                      buttonText: String?, buttonTap: (() -> Void)? = nil) {
        view.configureTheme(.info)

        view.titleLabel?.isHidden = true
        view.iconImageView?.isHidden = true
        view.button?.isHidden = buttonTap == nil
        view.button?.backgroundColor = UIColor.clear
        view.button?.tintColor = UIColor.white
        view.button?.titleLabel?.font = .boldSystemFont(ofSize: 14)
        view.button?.tintColor = AppColors.textForground.color()
        view.bodyLabel?.font = .boldSystemFont(ofSize: 16)
        view.backgroundColor? = AppColors.backkgroundDark.color()
        
        view.accessibilityIdentifier = "MessageDisplayerView"

        var topBottomPadding: CGFloat = 5
        if buttonTap == nil {
            view.configureContent(body: message)
            topBottomPadding = 9
        } else {
            var btnTitle = "BarButtonItem.view".localized().uppercased()
            if let theButtonText = buttonText {
                btnTitle = theButtonText
            }

            view.button?.isAccessibilityElement = true
            view.button?.accessibilityIdentifier = "MessageDisplayerViewButton"
            view.button?.titleLabel?.text = btnTitle
            view.configureContent(title: nil, body: message, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: btnTitle) { _ in
                buttonTap?()
                SwiftMessages.hide()
            }
        }

        view.layoutMarginAdditions = UIEdgeInsets(top: topBottomPadding, left: 10, bottom: topBottomPadding, right: 5)

        var config = SwiftMessages.Config()
        config.duration = .seconds(seconds: timeLimit.duration)
        config.interactiveHide = false

        if shouldBeCustomPosition {
            let fadeInOutAnimation = FadeInOutAnimation()
            fadeInOutAnimation.bottomAnchorConstant = customPosition
            config.presentationStyle = .custom(animator: fadeInOutAnimation)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + timeLimit.delay) {
            SwiftMessages.show(config: config, view: view)
        }
    }
}
