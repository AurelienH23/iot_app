//
//  ControlValue.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

class ControlValue: UILabel {

    // MARK: Properties

    private var value: Int {
        didSet {
            text = "\(value)"
        }
    }

    // MARK: View elements

    // MARK: Lifecycle

    init(_ value: Int) {
        self.value = value
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        text = "\(value)"
        textColor = .textColor
        textAlignment = .center
        font = .boldSystemFont(ofSize: 30)
    }

}
