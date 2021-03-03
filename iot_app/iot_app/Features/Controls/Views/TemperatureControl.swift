//
//  TemperatureControl.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

class TemperatureControl: UIView {

    // MARK: Properties

    private var value: CGFloat = 7.0
    private var tmpStartValue: CGFloat = 7.0

    // MARK: View elements

    // MARK: Lifecycle

    init() {
        super.init(frame: .zero)
        setupViews()
        updateSteps(for: value)
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
        clipsToBounds = true
        let steps = generatedSteps()
        let stack = VStack.items(steps, spaced: 4, displayed: .fillEqually)
        addSubview(stack)
        stack.anchor(to: self)
    }

    private func generatedSteps() -> [UIView] {
        var steps = [UIView]()
        for _ in 0...20 {
            steps.append(StepView())
        }
        return steps
    }

    internal func didSlideControl(with value: CGFloat) {
        
    }

    internal func updateStartValue() {
        tmpStartValue = 0
    }

    private func updateSteps(for value: CGFloat) {
        subviews.forEach({$0.alpha = 0})
    }

}
