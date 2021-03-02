//
//  HomeViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 01/03/2021.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: View elements

    private let profileButton = RoundedButton()
    let titleLabel = WelcomeTitle(name: "TEST")

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .backgroundColor
        view.addSubviews(profileButton, titleLabel)
        profileButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: .topPadding + .mediumSpace, paddingRight: .extraLargeSpace)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: .extraLargeSpace, paddingRight: .extraLargeSpace)
    }

}

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

class RoundedButton: UIButton {
    
    // MARK: Properties
    
    // MARK: View elements
    
    // MARK: Lifecycle
    
    init(image: String) {
        super.init(frame: .zero)
        setupViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = .elementBackground
    }

}
