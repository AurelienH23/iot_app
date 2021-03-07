//
//  BirthdateCard.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

class BirthdateCard: UIView {

    // MARK: View elements

    private let birthdateLabel = DetailLabel(aligned: .center)

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        anchor(height: 60)
        layer.cornerRadius = .largeCornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor?.cgColor
        backgroundColor = .elementBackground
        
        addSubview(birthdateLabel)
        birthdateLabel.anchor(to: self)
    }

    internal func setupContent(for user: User) {
        birthdateLabel.text = user.birthdateToString()
    }

}
