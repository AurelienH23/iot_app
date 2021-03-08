//
//  Caption.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

class Caption: UILabel {

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
        textColor = .textGray
        font = .systemFont(ofSize: 16, weight: .semibold)
    }

}
