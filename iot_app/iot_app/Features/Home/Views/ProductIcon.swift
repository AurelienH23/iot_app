//
//  ProductIcon.swift
//  iot_app
//
//  Created by Aurélien Haie on 04/03/2021.
//

import UIKit

class ProductIcon: UIImageView {

    // MARK: Lifecycle

    init(_ imageName: String) {
        var img: UIImage? = nil
        if #available(iOS 13.0, *) {
            if let systemImage = UIImage(systemName: imageName) {
                img = systemImage
            } else {
                img = UIImage(named: imageName)
            }
        } else {
            img = UIImage(named: imageName)
        }
        super.init(image: img?.withRenderingMode(.alwaysTemplate))
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Custom funcs

    private func setupViews() {
        heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        tintColor = .textGray
        contentMode = .scaleAspectFit
    }

}
