//
//  Device.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import Foundation

struct Device: Decodable {
    private let id: Int
    private(set) var deviceName: String
    private(set) var productType: String
    private let intensity: Int?
    private let mode: String?
    private let position: Int?
    private let temperature: Int?

    internal func associatedControl() -> ControlViewController? {
        switch productType {
        case "Light":
            return LightControlViewController(with: self)
        case "RollerShutter":
            return RollerShutterControlViewController(with: self)
        case "Heater":
            return HeaterControlViewController(with: self)
        default:
            return nil
        }
    }

}
