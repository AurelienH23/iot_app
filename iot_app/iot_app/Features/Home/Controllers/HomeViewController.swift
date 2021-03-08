//
//  HomeViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 01/03/2021.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: Properties

    private let viewModel = HomeViewModel()
    private let helper = HomeHelper()

    // MARK: View elements

    private let profileButton = RoundedButton(image: "ic_account", target: self, action: #selector(showProfile))
    private let titleLabel = WelcomeTitle(DataManager.shared.user?.nameToDisplay())
    // TODO: Mettre les filter dans une scroll view horizontale
    private let lightsFilter = FilterButton(.light, target: self, action: #selector(didSelectFilter(button:)))
    private let rollerShuttersFilter = FilterButton(.rollerShutter, target: self, action: #selector(didSelectFilter(button:)))
    private let heatersFilter = FilterButton(.heater, target: self, action: #selector(didSelectFilter(button:)))
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        helper.setupCells(for: cv)
        return cv
    }()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        setupNavBar()
        setupViews()
        animateViewsIn()
        setupBinders()
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollection), name: .devicesDidChange, object: nil)
    }

    private func setupNavBar() {
        navigationController?.isNavigationBarHidden = true
    }

    private func setupViews() {
        view.backgroundColor = .backgroundColor
        let filters = HStack.items([lightsFilter, rollerShuttersFilter, heatersFilter], spaced: .smallSpace)
        view.addSubviews(profileButton, titleLabel, filters, collectionView)
        profileButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: .topPadding + .mediumSpace, paddingRight: .extraLargeSpace)
        titleLabel.anchor(top: profileButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: .smallSpace, paddingLeft: .extraLargeSpace, paddingRight: .extraLargeSpace)
        filters.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, paddingTop: .extraLargeSpace)
        collectionView.anchor(top: filters.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }

    private func animateViewsIn() {
        collectionView.alpha = 0
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseIn, animations: {
            self.collectionView.alpha = 1
        }, completion: nil)
    }

    private func setupBinders() {
        viewModel.filters.bind { _ in
            self.collectionView.reloadSections([0])
        }
    }

    @objc private func showProfile() {
        let profileController = ProfileViewController()
        navigationController?.pushViewController(profileController, animated: true)
    }

    @objc private func didSelectFilter(button: FilterButton) {
        viewModel.updateFilters(with: button.filter, if: button.isFilterSelected)
    }

    @objc private func reloadCollection() {
        collectionView.reloadSections([0])
    }

}

// MARK: Collection view
extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentDevice = viewModel.getDevice(at: indexPath.item)
        return helper.cellForItem(at: indexPath, from: collectionView, with: currentDevice)
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return helper.cellSize(from: collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return helper.cellSpacing()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return helper.cellSpacing()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return helper.insets()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDevice = viewModel.getDevice(at: indexPath.item)
        guard let control = selectedDevice.associatedControl() else { return }
        present(control, animated: true, completion: nil)
    }

}
