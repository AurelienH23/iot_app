//
//  ControlValue.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

class ControlValue: UILabel {

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        textColor = .textColor
        textAlignment = .center
        font = .boldSystemFont(ofSize: 30)
    }

    internal func updateValue(with newValue: CGFloat) {
        text = "\(Int(newValue))"
    }

    internal func updateTemperature(with newValue: CGFloat) {
        let tmpInt = Int(newValue * 2)
        let tmpValue = Float(tmpInt) / 2
        text = String(format: "%.1f", tmpValue) + "°C"
    }

}
