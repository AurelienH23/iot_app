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

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: Custom funcs

    private func setupViews() {
        view.backgroundColor = .backgroundColor
        view.addSubviews(backButton, editButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: .topPadding + .mediumSpace, paddingLeft: .extraLargeSpace)
        editButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: .topPadding + .mediumSpace, paddingRight: .extraLargeSpace)
    }

    @objc private func goBackHome() {
        navigationController?.popViewController(animated: true)
    }

}
