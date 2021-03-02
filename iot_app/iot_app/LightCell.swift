//
//  LightCell.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

class LightCell: UICollectionViewCell {

    // MARK: Properties
    
    // MARK: View elements
    
    let titleLabel = TitleLabel("TEST de title")
    let switcher = Switcher()

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

class TitleLabel: UILabel {

    // MARK: Properties
    
    // MARK: View elements
    
    // MARK: Lifecycle
    
    init(_ text: String? = nil) {
        super.init(frame: .zero)
        self.text = text
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom funcs
    
    private func setupViews() {
        textColor = .textColor
        font = .boldSystemFont(ofSize: 20)
        numberOfLines = 0
    }

}

class Switcher: UISwitch {

    // MARK: Properties

    // MARK: View elements

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
        tintColor = .accentColor
    }

}
