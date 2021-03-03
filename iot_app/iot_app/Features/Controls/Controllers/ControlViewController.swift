//
//  ControlViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

protocol Switchable {
    var isSwitchable: Bool { get }
}

class ControlViewController: UIViewController {

    // MARK: Properties

    let device: Device

    // MARK: View elements

    private let dismissButton = RoundedButton(image: "chevron.down", target: self, action: #selector(goBackHome))
    private let deleteButton = RoundedButton(image: "trash", target: self, action: #selector(deleteDevice))
    private(set) lazy var deviceName = TitleLabel(device.deviceName)
    private(set) var intensityValue = ControlValue(50)
    private let bottomView = SwitchableView()

    // MARK: Lifecycle
    
    init(with device: Device) {
        self.device = device
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopButtons()
        setupViews()
        setupBottomViewIfNeeded()
    }

    // MARK: Custom funcs

    internal func setupViews() {
        view.backgroundColor = .backgroundColor
        view.addSubviews(deviceName, intensityValue)
        deviceName.anchor(top: dismissButton.bottomAnchor, left: dismissButton.leftAnchor, right: deleteButton.rightAnchor, paddingTop: .extraLargeSpace)
        intensityValue.anchor(top: deviceName.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: .extraLargeSpace)
    }

    private func setupTopButtons() {
        view.addSubviews(dismissButton, deleteButton)
        dismissButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: .extraLargeSpace, paddingLeft: .extraLargeSpace)
        deleteButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: .extraLargeSpace, paddingRight: .extraLargeSpace)
    }

    private func setupBottomViewIfNeeded() {
        guard isSwitchable else { return }
        view.addSubview(bottomView)
        bottomView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, height: .bottomPadding + 100)
    }

    @objc private func goBackHome() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func deleteDevice() {
        // delete device here
    }

}

extension ControlViewController: Switchable {

    @objc var isSwitchable: Bool {
        return true
    }

}