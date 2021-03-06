//
//  MapButton.swift
//  iot_app
//
//  Created by Aurélien Haie on 06/03/2021.
//

import UIKit

class MapButton: UIButton {

    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Custom funcs
    
    private func setupViews() {
        anchor(height: .standardTouchSpace)
        setTitle("Voir sur la carte", for: .normal)
        setTitleColor(.accentColor, for: .normal)
    }

    @objc private func didTapButton() {
        guard let address = DataManager.shared.user?.getAddress() else { return }
        UIApplication.shared.open(URL(string: "http://maps.apple.com/?address=\(address.adaptedForUrl())")!, options: [:], completionHandler: nil)
    }

}
