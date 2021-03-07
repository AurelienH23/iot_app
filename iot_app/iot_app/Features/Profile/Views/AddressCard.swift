//
//  AddressCard.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import UIKit

class AddressCard: UIView {

    // MARK: View elements

    private let streetLabel = DetailLabel()
    private let cityLabel = DetailLabel()
    private let countryLabel = DetailLabel()
    private let mapButton = MapButton()

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
        layer.cornerRadius = .largeCornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor?.cgColor
        backgroundColor = .elementBackground
        
        let details = VStack.items([streetLabel, cityLabel, countryLabel, mapButton], spaced: .smallSpace)
        addSubview(details)
        details.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: .largeSpace, paddingLeft: .largeSpace, paddingRight: .largeSpace)
        
        anchor(bottom: mapButton.bottomAnchor, paddingBottom: -.mediumSpace)
    }

    internal func setupContent(for user: User) {
        streetLabel.text = user.address.streetCode + " " + user.address.street
        cityLabel.text = "\(user.address.postalCode) " + user.address.city
        countryLabel.text = user.address.country
    }

}
