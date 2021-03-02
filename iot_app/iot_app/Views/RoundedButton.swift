//
//  RoundedButton.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

class RoundedButton: UIButton {
    
    // MARK: Lifecycle
    
    init(image: String) {
        super.init(frame: .zero)
        setImage(UIImage(named: image)?.withRenderingMode(.alwaysTemplate), for: .normal)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom funcs
    
    private func setupViews() {
        anchor(width: .standardTouchSpace, height: .standardTouchSpace)
        layer.cornerRadius = .largeCornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor?.cgColor
        backgroundColor = .elementBackground
        tintColor = .textColor
    }

}
