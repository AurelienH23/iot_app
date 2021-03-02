//
//  LightCell.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

class LightCell: UICollectionViewCell {

    // MARK: Properties

    internal var device: Device? {
        didSet {
            guard let device = device else { return }
            titleLabel.text = device.deviceName
        }
    }
    
    // MARK: View elements
    
    private let titleLabel = TitleLabel("TEST de title")
    private let switcher = Switcher()

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
        addSubviews(titleLabel, switcher)
        titleLabel.anchor(top: switcher.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: .smallSpace, paddingLeft: .mediumSpace, paddingRight: .mediumSpace)
        switcher.anchor(top: topAnchor, right: rightAnchor, paddingTop: .smallSpace, paddingRight: .smallSpace)
    }

}
