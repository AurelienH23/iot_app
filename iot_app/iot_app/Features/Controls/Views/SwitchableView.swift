//
//  SwitchableView.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

class SwitchableView: UIView {
    
    // MARK: Properties
    
    // MARK: View elements

    private let button = FilledButton("ON")
    
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
        addSubview(button)
        button.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: .mediumSpace, paddingLeft: .extraLargeSpace, paddingRight: .extraLargeSpace)
    }

}
