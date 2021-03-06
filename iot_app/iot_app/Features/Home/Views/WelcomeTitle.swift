//
//  WelcomeTitle.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

class WelcomeTitle: UILabel {

    // MARK: Lifecycle

    init(_ text: String?) {
        super.init(frame: .zero)
        setupViews()
        welcomeTheUser(named: text)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        numberOfLines = 2
    }

    internal func welcomeTheUser(named: String?) {
        guard let username = named else { return }
        let generatedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "greetings".localized(), attributes: [.font: UIFont.boldSystemFont(ofSize: 30)]))
        generatedText.append(NSAttributedString(string: username, attributes: [.font: UIFont.systemFont(ofSize: 30)]))
        attributedText = generatedText
    }

}
