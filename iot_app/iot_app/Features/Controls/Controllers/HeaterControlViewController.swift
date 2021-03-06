//
//  HeaterControlViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

class HeaterControlViewController: ControlViewController {
    
    private let temperatureControl = TemperatureControl()

    override func setupViews() {
        super.setupViews()
        view.addSubview(temperatureControl)
        temperatureControl.anchor(top: intensityValue.bottomAnchor, bottom: view.bottomAnchor, paddingTop: .mediumSpace, paddingBottom: .bottomPadding + 100 + .mediumSpace)
        temperatureControl.centerHorizontally(to: view)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didChangeValue(gesture:)))
        temperatureControl.addGestureRecognizer(pan)
        
        temperatureControl.temperature.bind { (value) in
            self.intensityValue.updateTemperature(with: value)
        }

        if let deviceTemperature = device.temperature {
            temperatureControl.temperature.value = CGFloat(deviceTemperature)
            temperatureControl.updateSteps(for: CGFloat(deviceTemperature))
        }
        bottomView.updateButton(for: device)
    }

    @objc private func didChangeValue(gesture: UIPanGestureRecognizer) {
        guard device.isOn() else { return }
        switch gesture.state {
        case .began:
            temperatureControl.updateStartValue()
        case .changed:
            let translated = gesture.translation(in: temperatureControl)
            let verticalTranslation = -translated.y
            temperatureControl.didSlideControl(with: verticalTranslation)
        case .ended:
            device.setTemperature(to: Float(temperatureControl.temperature.value))
        default:
            break
        }
    }

}

extension HeaterControlViewController {

    override func didSwitchMode() {
        device.switchMode()
    }

}
