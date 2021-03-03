//
//  FilledButton.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

class FilledButton: UIButton {
    
    // MARK: Properties
    
    // MARK: View elements
    
    // MARK: Lifecycle
    
    init(_ title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom funcs
    
    private func setupViews() {
        anchor(height: .standardTouchSpace)
        backgroundColor = .accentColor
        layer.cornerRadius = .largeCornerRadius
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 16)
    }

}
