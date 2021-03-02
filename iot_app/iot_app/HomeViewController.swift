//
//  HomeViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 01/03/2021.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: View elements

    private let profileButton = RoundedButton(image: "ic_account")
    private let titleLabel = WelcomeTitle(name: "TEST")
    private let lightsFilter = FilterButton(title: "Lights")
    private let rollerShuttersFilter = FilterButton(title: "Roller shutters")
    private let heatersFilter = FilterButton(title: "heaters")

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .backgroundColor
        let filters = HStack.items([lightsFilter, rollerShuttersFilter, heatersFilter], spaced: .smallSpace)
        lightsFilter.isFilterSelected = true
        view.addSubviews(profileButton, titleLabel, filters)
        profileButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: .topPadding + .mediumSpace, paddingRight: .extraLargeSpace)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: .extraLargeSpace, paddingRight: .extraLargeSpace)
        filters.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, paddingTop: .extraLargeSpace)
    }

}

class FilterButton: UIButton {
    
    // MARK: Properties
    
    internal var isFilterSelected = false {
        didSet {
            updateViews(selected: isFilterSelected)
        }
    }
    
    // MARK: Lifecycle
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupViews()
        updateViews(selected: false)
        addTarget(self, action: #selector(didSelectFilter), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let padding: CGFloat = 13
        return CGSize(width: size.width + 2 * padding, height: size.height)
    }
    
    // MARK: Custom funcs
    
    private func setupViews() {
        anchor(height: 30)
        layer.cornerRadius = 15
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    private func updateViews(selected: Bool) {
        backgroundColor = selected ? .accentColor : .elementBackground
        setTitleColor(selected ? .white : .textGray, for: .normal)
    }

    @objc private func didSelectFilter() {
        isFilterSelected.toggle()
    }

}
