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
    }

    @objc private func didChangeValue(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            intensityControl.updateStartValue()
        case .changed:
            let translated = gesture.translation(in: intensityControl)
            let verticalTranslation = -translated.y
            intensityControl.didSlideControl(with: verticalTranslation)
        default:
            break
        }
    }

}

class IntensityControl: UIView {

    // MARK: Properties

    private var heightConstraint: NSLayoutConstraint?
    private var tmpStartValue: CGFloat = 100

    // MARK: View elements
    
    private let valueView: UIView = {
        let view = UIView()
        view.backgroundColor = .textColor
        view.layer.cornerRadius = .largeCornerRadius
        return view
    }()

    // MARK: Lifecycle

    init(for filter: Filter) {
        super.init(frame: .zero)
        setupViews()
        setupControl(for: filter)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        anchor(width: 100)
        layer.cornerRadius = .largeCornerRadius
        layer.borderWidth = 2
        layer.borderColor = UIColor.textColor?.cgColor
        backgroundColor = .elementBackground
        addSubview(valueView)

        heightConstraint = valueView.heightAnchor.constraint(equalToConstant: tmpStartValue)
        heightConstraint?.isActive = true
    }

    private func setupControl(for filter: Filter) {
        switch filter {
        case .light:
            valueView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        case .rollerShutter:
            valueView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        default:
            break
        }
    }

    internal func didSlideControl(with value: CGFloat) {
        let newValue = tmpStartValue + value
        guard newValue < frame.height, newValue > 0 else { return }
        heightConstraint?.constant = newValue
    }

    internal func updateStartValue() {
        tmpStartValue = heightConstraint?.constant ?? 0
    }

}
