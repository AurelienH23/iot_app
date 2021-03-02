//
//  HomeViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 01/03/2021.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: Properties

    enum CellId: String {
        case light
    }

    // MARK: View elements

    private let profileButton = RoundedButton(image: "ic_account")
    private let titleLabel = WelcomeTitle()
    private let lightsFilter = FilterButton(title: "Lights")
    private let rollerShuttersFilter = FilterButton(title: "Roller shutters")
    private let heatersFilter = FilterButton(title: "Heaters")
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .clear
        cv.register(LightCell.self, forCellWithReuseIdentifier: CellId.light.rawValue)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        setupViews()
        
    }

    private func setupObservers() {
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

    private func setupViews() {
        view.backgroundColor = .backgroundColor
        let filters = HStack.items([lightsFilter, rollerShuttersFilter, heatersFilter], spaced: .smallSpace)
        lightsFilter.isFilterSelected = true
        view.addSubviews(profileButton, titleLabel, filters, collectionView)
        profileButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: .topPadding + .mediumSpace, paddingRight: .extraLargeSpace)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: .extraLargeSpace, paddingRight: .extraLargeSpace)
        filters.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, paddingTop: .extraLargeSpace)
        collectionView.anchor(top: filters.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }

}

// MARK: Collection view
extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.devices.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.light.rawValue, for: indexPath) as! LightCell
        cell.titleLabel.text = "Texte a afficher" // DataManager.shared.devices[indexPath.item]
        return cell
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

}
