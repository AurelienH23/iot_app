//
//  TitleLabel.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

class TitleLabel: UILabel {

    // MARK: Properties
    
    // MARK: View elements
    
    // MARK: Lifecycle
    
    init(_ text: String? = nil, aligned: NSTextAlignment = .left) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = aligned
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
