//
//  LightButton.swift
//  iot_app
//
//  Created by Aurélien Haie on 04/03/2021.
//

import UIKit

class LightButton: UIButton {
    
    // MARK: Lifecycle
    
    init(_ title: String, target: Any?, action: Selector) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        addTarget(target, action: action, for: .touchUpInside)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom funcs
    
    private func setupViews() {
        anchor(height: .standardTouchSpace)
        backgroundColor = .elementBackground
        layer.cornerRadius = .standardTouchSpace / 2
    }

}
