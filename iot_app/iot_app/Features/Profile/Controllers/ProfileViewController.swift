//
//  ProfileViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: View elements

    let backButton = RoundedButton(image: "arrow.left", target: self, action: #selector(goBackHome))
    let editButton = RoundedButton(image: "pencil", target: self, action: #selector(editProfile))
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

    @objc private func editProfile() {
        // do stuff here
    }

}
