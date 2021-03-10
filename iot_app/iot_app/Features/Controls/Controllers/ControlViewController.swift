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

    var device: Device {
        didSet {
            DataManager.shared.update(device)
            updateViews(for: device)
        }
    }

    // MARK: View elements

    private let dismissButton = RoundedButton(image: "chevron.down", target: self, action: #selector(goBackHome))
    private let deleteButton = RoundedButton(image: "trash", target: self, action: #selector(deleteDevice))
    private(set) lazy var deviceName = TitleLabel(device.deviceName)
    private(set) var intensityValue = ControlValue()
    internal lazy var bottomView = SwitchableView(delegate: self)

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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: .devicesDidChange, object: nil)
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

    internal func updateViews(for device: Device) {
        bottomView.updateButton(for: device)
    }

    @objc internal func deleteDevice() {
        let alert = UIAlertController(title: "Voulez-vous supprimer cet appareil ?", message: "Vous ne pourrez pas revenir en arrière", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Supprimer", style: .destructive, handler: { action in
            DataManager.shared.delete(self.device) {
                self.dismiss(animated: true, completion: nil)
            }
        }))
        present(alert, animated: true, completion: nil)
    }

}

extension ControlViewController: Switchable {

    @objc var isSwitchable: Bool {
        return true
    }

}

extension ControlViewController: SwitchableDelegate {

    @objc func didSwitchMode() {
        // override this method
    }

}
