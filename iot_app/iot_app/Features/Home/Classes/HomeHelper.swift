//
//  HomeHelper.swift
//  iot_app
//
//  Created by Aurélien Haie on 06/03/2021.
//

import UIKit

class HomeHelper {
    
    // MARK: Properties

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

    // MARK: Custom funcs

    internal func setupCells(for collectionView: UICollectionView) {
        CellId.allCases.forEach({collectionView.register($0.associatedCell(), forCellWithReuseIdentifier: $0.rawValue)})
    }

    internal func cellForItem(at indexPath: IndexPath, from collectionView: UICollectionView, with device: Device) -> UICollectionViewCell {
        switch device.productType {
        case "Light":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.light.rawValue, for: indexPath) as! LightCell
            cell.device = device
            return cell
        case "RollerShutter":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.rollerShutter.rawValue, for: indexPath) as! RollerShutterCell
            cell.device = device
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.heater.rawValue, for: indexPath) as! HeaterCell
            cell.device = device
            return cell
        }
    }

    internal func cellSize(from collectionView: UICollectionView) -> CGSize {
        let cellWidth = (collectionView.frame.width - 2 * .extraLargeSpace - .mediumSpace) / 2
        return CGSize(width: cellWidth, height: 160)
    }

    internal func cellSpacing() -> CGFloat {
        return .mediumSpace
    }

    internal func insets() -> UIEdgeInsets {
        return UIEdgeInsets(top: .mediumSpace, left: .extraLargeSpace, bottom: .extraLargeSpace, right: .extraLargeSpace)
    }
}
