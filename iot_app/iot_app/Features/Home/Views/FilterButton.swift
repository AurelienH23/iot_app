//
//  FilterButton.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit

class FilterButton: UIButton {
    
    // MARK: Properties
    
    private(set) var filter: Filter
    
    internal var isFilterSelected = false {
        didSet {
            updateViews(selected: isFilterSelected)
        }
    }
    
    // MARK: Lifecycle
    
    init(_ filter: Filter, target: Any?, action: Selector) {
        self.filter = filter
        super.init(frame: .zero)
        setupViews()
        updateViews(selected: false)
        addTarget(self, action: #selector(didSelectFilter), for: .touchUpInside)
        addTarget(target, action: action, for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let padding: CGFloat = 13
        return CGSize(width: size.width + 2 * padding, height: size.height)
    }
    
    // MARK: Custom funcs
    
    private func setupViews() {
        anchor(height: 30)
        layer.cornerRadius = 15
        setTitle(filter.displayedName(), for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    private func updateViews(selected: Bool) {
        backgroundColor = selected ? .accentColor : .elementBackground
        setTitleColor(selected ? .white : .textGray, for: .normal)
    }

    @objc private func didSelectFilter() {
        isFilterSelected.toggle()
    }

}
