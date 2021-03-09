//
//  TemperatureControl.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

class TemperatureControl: UIView {

    // MARK: Properties

    internal var temperature: Listener<CGFloat> = Listener(7.0)
    private var tmpStartValue: CGFloat = 7.0

    // MARK: View elements

    // MARK: Lifecycle

    init() {
        super.init(frame: .zero)
        setupViews()
        updateSteps(for: temperature.value)
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
        let changePercent = value / frame.height
        let changeDegrees = 21 * changePercent
        let newValue = tmpStartValue + changeDegrees
        let checkedValue = max(7, min(newValue, 28))
        updateSteps(for: checkedValue)
        temperature.value = checkedValue
    }

    internal func updateStartValue() {
        tmpStartValue = temperature.value
    }

    internal func updateSteps(for value: CGFloat) {
        let startingStepIndex = getStartingStepIndex(for: value)
        let isDecimal = isHalfStep(for: value)
        guard let steps = subviews.first as? UIStackView else { return }
        for (i, step) in steps.arrangedSubviews.enumerated() {
            step.alpha = i > startingStepIndex ? 1 : 0
            if i == startingStepIndex {
                step.alpha = isDecimal ? 0.5 : 0
            }
        }
    }

    private func getStartingStepIndex(for value: CGFloat) -> Int {
        let delta = value - 7
        return 20 - Int(delta)
    }

    private func isHalfStep(for value: CGFloat) -> Bool {
        let tmpValue = value * 2
        let tmpInt = Int(tmpValue)
        let realValue = CGFloat(tmpInt) / 2
        return String(format: "%.1f", realValue).last == "5"
    }

}
