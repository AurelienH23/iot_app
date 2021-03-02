//
//  WelcomeTitle.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

class WelcomeTitle: UILabel {

    // MARK: Properties

    private var username: String

    // MARK: Lifecycle

    init(name: String) {
        username = name
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        numberOfLines = 2
        let generatedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "Welcome home,\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 30)]))
        generatedText.append(NSAttributedString(string: "Arthur", attributes: [.font: UIFont.systemFont(ofSize: 30)]))
        attributedText = generatedText
    }

}
