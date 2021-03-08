//
//  IntensityControl.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

class IntensityControl: UIView {

    // MARK: Properties

    internal var intensity: Listener<CGFloat> = Listener(50)
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
        let checkedValue = max(0, min(newValue, frame.height))
        heightConstraint?.constant = checkedValue
        intensity.value = checkedValue / frame.height * 100
    }

    internal func updateStartValue() {
        tmpStartValue = heightConstraint?.constant ?? 0
    }

    internal func setValueHeight(to value: CGFloat) {
        heightConstraint?.constant = (value / 100) * frame.height
    }

}
