//
//  LaunchViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 04/03/2021.
//

import UIKit

class LaunchViewController: UIViewController {

    // MARK: View elements
    
    let logo = UIImageView(image: UIImage(named: "logo"))
    let loader = UIActivityIndicatorView(style: .white)
    let errorText = Caption("Erreur de connexion")
    let tryAgainButton = LightButton("Try again", target: self, action: #selector(reloadApplicationData))

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


class LightButton: UIButton {
    
    // MARK: Properties
    
    // MARK: View elements
    
    // MARK: Lifecycle
    
    init(_ title: String, target: Any?, action: Selector) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        addTarget(target, action: action, for: .touchUpInside)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom funcs
    
    private func setupViews() {
        anchor(height: .standardTouchSpace)
        backgroundColor = .elementBackground
        layer.cornerRadius = .standardTouchSpace / 2
    }

}
