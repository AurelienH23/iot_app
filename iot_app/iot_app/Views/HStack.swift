//
//  HStack.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

class HStack: UIStackView {

    static internal func items(_ items: [UIView], spaced: CGFloat, displayed: UIStackView.Distribution = .fill) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: items)
        stack.axis = .horizontal
        stack.distribution = displayed
        stack.spacing = spaced
        return stack
    }

}
