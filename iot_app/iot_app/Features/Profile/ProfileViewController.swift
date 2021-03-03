//
//  ProfileViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: View elements

    let backButton = RoundedButton(image: "", target: self, action: #selector(goBackHome))
    let editButton = RoundedButton(image: "", target: self, action: #selector(goBackHome))
    let nameLabel = TitleLabel("John Doe", aligned: .center)
    let addressCaption = Caption("Address")
    let addressCard = AddressCard()
    let birthdateCaption = Caption("Birthdate")
    let birthdateCard = BirthdateCard()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: Custom funcs

    private func setupViews() {
        view.backgroundColor = .backgroundColor
        let details = VStack.items([addressCaption, addressCard, birthdateCaption, birthdateCard], spaced: .smallSpace)
        view.addSubviews(backButton, editButton, nameLabel, details)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: .topPadding + .mediumSpace, paddingLeft: .extraLargeSpace)
        editButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: .topPadding + .mediumSpace, paddingRight: .extraLargeSpace)
        nameLabel.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: .extraLargeSpace, paddingLeft: .extraLargeSpace, paddingRight: .extraLargeSpace)
        details.anchor(top: nameLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: .extraLargeSpace, paddingLeft: .extraLargeSpace, paddingRight: .extraLargeSpace)
    }

    @objc private func goBackHome() {
        navigationController?.popViewController(animated: true)
    }

}

class Caption: UILabel {

    // MARK: Properties

    // MARK: View elements

    // MARK: Lifecycle

    init(_ text: String) {
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

class AddressCard: UIView {

    // MARK: Properties

    // MARK: View elements

    let streetLabel = DetailLabel("Rue")
    let cityLabel = DetailLabel("Ville")
    let countryLabel = DetailLabel("Pays")

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        guard let user = DataManager.shared.user else { return }
        updateContent(for: user)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        anchor(height: 200)
        layer.cornerRadius = .largeCornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor?.cgColor
        backgroundColor = .elementBackground
        
        let details = VStack.items([streetLabel, cityLabel, countryLabel], spaced: .smallSpace)
        addSubview(details)
        details.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: .largeSpace, paddingLeft: .largeSpace, paddingRight: .largeSpace)
    }

    private func updateContent(for user: User) {
        streetLabel.text = user.address.streetCode + " " + user.address.street
        cityLabel.text = "\(user.address.postalCode) " + user.address.city
        countryLabel.text = user.address.country
    }

}

class DetailLabel: UILabel {

    // MARK: Properties

    // MARK: View elements

    // MARK: Lifecycle

    init(_ text: String, aligned: NSTextAlignment = .left) {
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

class BirthdateCard: UIView {

    // MARK: Properties

    // MARK: View elements

    let birthdateLabel = DetailLabel("27/01/1995", aligned: .center)

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        guard let user = DataManager.shared.user else { return }
        updateContent(for: user)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        anchor(height: 60)
        layer.cornerRadius = .largeCornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor?.cgColor
        backgroundColor = .elementBackground
        
        addSubview(birthdateLabel)
        birthdateLabel.anchor(to: self)
    }

    private func updateContent(for user: User) {
        birthdateLabel.text = user.birthdateToString()
    }

}
