//
//  Extensions.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

// MARK: UIView
extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach { (view) in
            addSubview(view)
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat = 0,
                height: CGFloat = 0) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    func anchor(to view: UIView) {
        anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }

    func anchor(to view: UIView, padding: CGFloat) {
        anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: padding, paddingLeft: padding, paddingBottom: padding, paddingRight: padding, width: 0, height: 0)
    }

    func centerVertically(to view: UIView) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func centerHorizontally(to view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

}

// MARK: UIColor
extension UIColor {

    static let backgroundColor = UIColor(named: "backgroundColor")
    static let elementBackground = UIColor(named: "elementBackground")
    static let borderColor = UIColor(named: "borderColor")
    static let textColor = UIColor(named: "textColor")
    static let textGray = UIColor(named: "textGray")
    static let accentColor = UIColor(named: "AccentColor")

}

// MARK: CGFloat
extension CGFloat {

    static var topPadding: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }

    static var bottomPadding: CGFloat {
        var bottomPadding: CGFloat = 0
        if self.topPadding > 20 {
            bottomPadding = 20
        }
        return bottomPadding
    }

    static var tabBarHeight: CGFloat {
        var bottomPadding: CGFloat = 50
        if self.topPadding > 20 {
            bottomPadding = 63
        }
        return bottomPadding
    }

    // Corner radius
    /** 4 */
    static let smallCornerRadius = CGFloat(integerLiteral: 4)
    /** 8 */
    static let mediumCornerRadius = CGFloat(integerLiteral: 8)
    /** 16 */
    static let largeCornerRadius = CGFloat(integerLiteral: 16)
    /** 32 */
    static let extraLargeCornerRadius = CGFloat(integerLiteral: 32)

    // Spacing
    /** 8 */
    static let smallSpace = CGFloat(integerLiteral: 8)
    /** 16 */
    static let mediumSpace = CGFloat(integerLiteral: 16)
    /** 24 */
    static let largeSpace = CGFloat(integerLiteral: 24)
    /** 32 */
    static let extraLargeSpace = CGFloat(integerLiteral: 32)
    /** 44 */
    static let standardTouchSpace = CGFloat(integerLiteral: 44)

    func showPercent() -> String {
        return "\(Int(self * 100))"
    }

}
