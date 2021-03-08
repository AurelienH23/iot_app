//
//  LightControlViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

class LightControlViewController: ControlViewController {

    private let intensityControl = IntensityControl(for: .light)

    override func setupViews() {
        super.setupViews()
        view.addSubview(intensityControl)
        intensityControl.anchor(top: intensityValue.bottomAnchor, bottom: view.bottomAnchor, paddingTop: .mediumSpace, paddingBottom: .bottomPadding + 100 + .mediumSpace)
        intensityControl.centerHorizontally(to: view)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didChangeValue(gesture:)))
        intensityControl.addGestureRecognizer(pan)
        
        intensityControl.intensity.bind { (value) in
            self.intensityValue.updateValue(with: value)
        }

        if let deviceIntensity = device.intensity {
            intensityControl.intensity.value = CGFloat(deviceIntensity)
            view.layoutIfNeeded()
            intensityControl.setValueHeight(to: CGFloat(deviceIntensity))
        }
        bottomView.updateButton(for: device)
    }

    @objc private func didChangeValue(gesture: UIPanGestureRecognizer) {
        guard device.isOn() else { return }
        switch gesture.state {
        case .began:
            intensityControl.updateStartValue()
        case .changed:
            let translated = gesture.translation(in: intensityControl)
            let verticalTranslation = -translated.y
            intensityControl.didSlideControl(with: verticalTranslation)
        case .ended:
            device.setIntensity(to: Int(intensityControl.intensity.value))
        default:
            break
        }
    }

}

extension LightControlViewController {

    override func didSwitchMode() {
        device.switchMode()
    }

}
