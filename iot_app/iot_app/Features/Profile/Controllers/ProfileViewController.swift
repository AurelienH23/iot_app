//
//  ProfileViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: View elements

    private let backButton = RoundedButton(image: "arrow.left", target: self, action: #selector(goBackHome))
    private let editButton = RoundedButton(image: "pencil", target: self, action: #selector(editProfile))
    private let nameLabel = TitleLabel(aligned: .center)
    private let addressCaption = Caption("addressCaption".localized())
    private let addressCard = AddressCard()
    private let birthdateCaption = Caption("birthdateCaption".localized())
    private let birthdateCard = BirthdateCard()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        setupViews()
        setupContent()
        animateViewsIn()
    }

    // MARK: Custom funcs

    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateContentForUser), name: .userDidChange, object: nil)
    }

    private func setupViews() {
        view.backgroundColor = .backgroundColor
        let details = VStack.items([addressCaption, addressCard, birthdateCaption, birthdateCard], spaced: .smallSpace)
        view.addSubviews(backButton, editButton, nameLabel, details)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: .topPadding + .mediumSpace, paddingLeft: .extraLargeSpace)
        editButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: .topPadding + .mediumSpace, paddingRight: .extraLargeSpace)
        nameLabel.anchor(top: backButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: .extraLargeSpace, paddingLeft: .extraLargeSpace, paddingRight: .extraLargeSpace)
        details.anchor(top: nameLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: .extraLargeSpace, paddingLeft: .extraLargeSpace, paddingRight: .extraLargeSpace)
    }

    private func setupContent() {
        guard let user = DataManager.shared.user else { return }
        nameLabel.text = user.fullName()
        addressCard.setupContent(for: user)
        birthdateCard.setupContent(for: user)
    }

    private func animateViewsIn() {
        let animatedViews = [nameLabel, addressCaption, addressCard, birthdateCaption, birthdateCard]
        animatedViews.forEach { (subview) in
            subview.alpha = 0
            subview.transform = CGAffineTransform(translationX: view.frame.width, y: 0)
        }
        for (i, subview) in animatedViews.enumerated() {
            UIView.animate(withDuration: 1, delay: TimeInterval(i) * 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                subview.alpha = 1
                subview.transform = .identity
            }, completion: nil)
        }
    }

    @objc private func updateContentForUser() {
        guard let user = DataManager.shared.user else { return }
        nameLabel.text = user.fullName()
    }

    @objc private func goBackHome() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func editProfile() {
        let alert = UIAlertController(title: "editAlertTitle".localized(), message: nil, preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "firstnamePlaceholder".localized()
        }
        alert.addTextField { (textfield) in
            textfield.placeholder = "lastnamePlaceholder".localized()
        }
        alert.addAction(UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "validate".localized(), style: .destructive, handler: { (action) in
            guard let firstnameInput = alert.textFields?[0], firstnameInput.text != nil, firstnameInput.text != "",
                  let lastnameInput = alert.textFields?[1], lastnameInput.text != nil, lastnameInput.text != "" else { return }
            DataManager.shared.updateUser(firstname: firstnameInput.text!, lastname: lastnameInput.text!)
        }))
        present(alert, animated: true, completion: nil)
    }

}
