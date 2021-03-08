//
//  SwitchableView.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

protocol SwitchableDelegate: class {
    func didSwitchMode()
}

class SwitchableView: UIView {
    
    // MARK: Properties

    weak var delegate: SwitchableDelegate?

    // MARK: View elements

    private let button = FilledButton("ON", target: self, action: #selector(didSwitchMode))
    
    // MARK: Lifecycle
    
    init(delegate: SwitchableDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom funcs
    
    private func setupViews() {
        backgroundColor = .elementBackground
        addSubview(button)
        button.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: .mediumSpace, paddingLeft: .extraLargeSpace, paddingRight: .extraLargeSpace)
    }

    @objc private func didSwitchMode() {
        delegate?.didSwitchMode()
    }

    internal func updateButton(for device: Device) {
        button.update(isOn: device.isOn())
    }

}
