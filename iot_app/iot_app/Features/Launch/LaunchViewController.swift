//
//  LaunchViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 04/03/2021.
//

import UIKit

class LaunchViewController: UIViewController {

    // MARK: View elements
    
    private let logo = UIImageView(image: UIImage(named: "logo"))
    private let loader = UIActivityIndicatorView(style: .white)
    private let errorText = Caption("Erreur de connexion")
    private let tryAgainButton = LightButton("Try again", target: self, action: #selector(reloadApplicationData))

    // MARK: Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
        setupObservers()
        loadApplicationData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    // MARK: Custom func

    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(launchApp), name: .didLoadData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorViews), name: .failedLoadingData, object: nil)
    }

    private func loadApplicationData() {
        DataManager.shared.startup()
    }

    private func setupViews() {
        view.backgroundColor = .backgroundColor
        view.addSubviews(logo, loader)
        logo.anchor(bottom: view.centerYAnchor, paddingBottom: 100, width: 100, height: 100)
        logo.centerHorizontally(to: view)
        loader.anchor(top: view.centerYAnchor, paddingTop: 50)
        loader.centerHorizontally(to: view)
        loader.startAnimating()
    }

    @objc private func launchApp() {
        DispatchQueue.main.async { [unowned self] in
            loader.stopAnimating()
            NotificationCenter.default.post(name: .startApp, object: nil)
        }
    }

    @objc private func showErrorViews() { // TODO: hide or show views
        DispatchQueue.main.async { [unowned self] in
            loader.stopAnimating()

            view.addSubviews(errorText, tryAgainButton)
            errorText.anchor(top: view.centerYAnchor)
            errorText.centerHorizontally(to: view)
            tryAgainButton.anchor(top: errorText.bottomAnchor, paddingTop: .extraLargeSpace, width: 100)
            tryAgainButton.centerHorizontally(to: view)
        }
    }

    @objc private func reloadApplicationData() {
        loader.startAnimating()
        [errorText, tryAgainButton].forEach { (errorView) in
            errorView.removeConstraints(errorView.constraints)
            errorView.removeFromSuperview()
        }
        loadApplicationData()
    }

}
