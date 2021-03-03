//
//  HomeViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 01/03/2021.
//

import UIKit

// TODO: Ajouter un helper pour le collection view afin de mieux le tester
class HomeViewController: UIViewController {

    // MARK: Properties

    let viewModel = HomeViewModel()

    enum CellId: String, CaseIterable {
        case light
        case rollerShutter
        case heater
        
        internal func associatedCell() -> UICollectionViewCell.Type {
            switch self {
            case .light:
                return LightCell.self
            case .rollerShutter:
                return RollerShutterCell.self
            case .heater:
                return HeaterCell.self
            }
        }
    }

    // MARK: View elements

    private let profileButton = RoundedButton(image: "ic_account", target: self, action: #selector(showProfile))
    private let titleLabel = WelcomeTitle()
    private let lightsFilter = FilterButton(.light, target: self, action: #selector(didSelectFilter(button:)))
    private let rollerShuttersFilter = FilterButton(.rollerShutter, target: self, action: #selector(didSelectFilter(button:)))
    private let heatersFilter = FilterButton(.heater, target: self, action: #selector(didSelectFilter(button:)))
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        CellId.allCases.forEach({cv.register($0.associatedCell(), forCellWithReuseIdentifier: $0.rawValue)})
        return cv
    }()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        setupNavBar()
        setupViews()
        setupBinders()
    }

    private func setupObservers() { // FIXME: Observers ne fonctionnent pas tout le temps
        DataManager.shared.userObservers.append { updatedUser in
            DispatchQueue.main.async {
                self.titleLabel.welcomeTheUser(named: updatedUser?.nameToDisplay())
            }
        }
        
        DataManager.shared.devicesObservers.append { _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
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

}

// MARK: Collection view
extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentDevice = viewModel.selectedDevice(at: indexPath.item)
        switch currentDevice.productType {
        case "Light":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.light.rawValue, for: indexPath) as! LightCell
            cell.device = currentDevice
            return cell
        case "RollerShutter":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.rollerShutter.rawValue, for: indexPath) as! RollerShutterCell
            cell.device = currentDevice
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.heater.rawValue, for: indexPath) as! HeaterCell
            cell.device = currentDevice
            return cell
        }
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 2 * .extraLargeSpace - .mediumSpace) / 2
        return CGSize(width: cellWidth, height: 120)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .mediumSpace
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .mediumSpace
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .mediumSpace, left: .extraLargeSpace, bottom: .extraLargeSpace, right: .extraLargeSpace)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDevice = viewModel.selectedDevice(at: indexPath.item)
        guard let control = selectedDevice.associatedControl() else { return }
        present(control, animated: true, completion: nil)
    }

}
