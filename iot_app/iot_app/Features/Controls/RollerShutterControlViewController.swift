//
//  RollerShutterControlViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

class RollerShutterControlViewController: ControlViewController {
    
    private let intensityControl = IntensityControl(for: .rollerShutter)

    override func setupViews() {
        super.setupViews()
        view.addSubview(intensityControl)
        intensityControl.anchor(top: intensityValue.bottomAnchor, bottom: view.bottomAnchor, paddingTop: .mediumSpace, paddingBottom: .bottomPadding + 100 + .mediumSpace)
        intensityControl.centerHorizontally(to: view)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didChangeValue(gesture:)))
        intensityControl.addGestureRecognizer(pan)
    }

    @objc private func didChangeValue(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            intensityControl.updateStartValue()
        case .changed:
            let translated = gesture.translation(in: intensityControl)
            let verticalTranslation = translated.y
            intensityControl.didSlideControl(with: verticalTranslation)
        default:
            break
        }
    }
    
}

// MARK: Switchable
extension RollerShutterControlViewController {

    override var isSwitchable: Bool {
        return false
    }

}
