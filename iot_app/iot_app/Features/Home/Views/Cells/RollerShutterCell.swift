//
//  RollerShutterCell.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

class RollerShutterCell: UICollectionViewCell {

    // MARK: Properties

    internal var device: Device? {
        didSet {
            guard let device = device else { return }
            titleLabel.text = device.deviceName
        }
    }
    
    // MARK: View elements
    
    private let icon = ProductIcon("rays")
    private let valueLabel = Caption("50%")
    private let titleLabel = TitleLabel()

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
        backgroundColor = .elementBackground
        layer.cornerRadius = .largeCornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor?.cgColor
        let details = HStack.items([icon, valueLabel], spaced: .smallSpace)
        addSubviews(details, titleLabel)
        details.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: .smallSpace, height: 25)
        titleLabel.anchor(top: details.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: .mediumSpace, paddingRight: .mediumSpace)
    }

}
