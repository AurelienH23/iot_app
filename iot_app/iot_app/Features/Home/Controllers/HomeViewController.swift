//
//  HomeViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 01/03/2021.
//

import UIKit

enum Filter {
    case light
    case rollerShutter
    case heater
    
    internal func displayedName() -> String {
        switch self {
        case .light:
            return "Lights"
        case .rollerShutter:
            return "Roller shutters"
        case .heater:
            return "Heaters"
        }
    }

    static func getFilter(associatedTo productType: String) -> Filter {
        let associations: [String: Filter] = ["Light": .light,
                                              "RollerShutter": .rollerShutter,
                                              "Heater": .heater]
        return associations[productType]!
    }
}

class HomeViewController: UIViewController {

    // MARK: Properties

    enum CellId: String {
        case light
        case rollerShutter
        case heater
    }

    private var filters = Set<Filter>() {
        didSet {
            collectionView.reloadData()
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
        cv.register(LightCell.self, forCellWithReuseIdentifier: CellId.light.rawValue)
        cv.register(RollerShutterCell.self, forCellWithReuseIdentifier: CellId.rollerShutter.rawValue)
        cv.register(HeaterCell.self, forCellWithReuseIdentifier: CellId.heater.rawValue)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        setupNavBar()
        setupViews()
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

    @objc private func showProfile() {
        let profileController = ProfileViewController()
        navigationController?.pushViewController(profileController, animated: true)
    }

    @objc private func didSelectFilter(button: FilterButton) {
        if button.isFilterSelected {
            filters.insert(button.filter)
        } else {
            filters.remove(button.filter)
        }
    }

}

// MARK: Collection view
extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filters.isEmpty {
            return DataManager.shared.devices.count
        } else {
            let filteredDevices = DataManager.shared.devices.filter { (device) -> Bool in
                return self.filters.contains(Filter.getFilter(associatedTo: device.productType))
            }
            return filteredDevices.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var devices = DataManager.shared.devices
        if !filters.isEmpty {
            devices = DataManager.shared.devices.filter { (device) -> Bool in
                return self.filters.contains(Filter.getFilter(associatedTo: device.productType))
            }
        }
        let currentDevice = devices[indexPath.item]
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
        let control = ControlViewController()
        present(control, animated: true, completion: nil)
    }

}
