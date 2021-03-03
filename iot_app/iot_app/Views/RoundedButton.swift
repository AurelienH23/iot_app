//
//  RoundedButton.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

class RoundedButton: UIButton {
    
    // MARK: Lifecycle
    
    init(image: String, target: Any?, action: Selector) {
        super.init(frame: .zero)
        var img: UIImage? = nil
        if #available(iOS 13.0, *) {
            if let systemImage = UIImage(systemName: image) {
                img = systemImage
            } else {
                img = UIImage(named: image)
            }
        } else {
            img = UIImage(named: image)
        }
        setImage(img?.withRenderingMode(.alwaysTemplate), for: .normal)
        addTarget(target, action: action, for: .touchUpInside)
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
