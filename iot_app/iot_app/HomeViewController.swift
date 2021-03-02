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
    private let titleLabel = WelcomeTitle(name: "TEST")

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupViews()
    }

    private func fetchData() {
        Network.session.fetchData()
    }

    private func setupViews() {
        view.backgroundColor = .backgroundColor
        view.addSubviews(profileButton, titleLabel)
        profileButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: .topPadding + .mediumSpace, paddingRight: .extraLargeSpace)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: .extraLargeSpace, paddingRight: .extraLargeSpace)
    }

}
