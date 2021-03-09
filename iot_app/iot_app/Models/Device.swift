//
//  Device.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import Foundation

struct Device: Decodable {
    private(set) var id: Int
    private(set) var deviceName: String
    private(set) var productType: String
    private(set) var intensity: Int?
    private(set) var mode: String?
    private(set) var position: Int?
    private(set) var temperature: Float?

    static func createLight(id: Int, deviceName: String, intensity: Int, mode: String) -> Device {
        return Device(id: id, deviceName: deviceName, productType: "Light", intensity: intensity, mode: mode, position: nil, temperature: nil)
    }

    static func createRollerShutter(id: Int, deviceName: String, position: Int) -> Device {
        return Device(id: id, deviceName: deviceName, productType: "RollerShutter", intensity: nil, mode: nil, position: position, temperature: nil)
    }
    
    static func createHeater(id: Int, deviceName: String, mode: String, temperature: Float) -> Device {
        return Device(id: id, deviceName: deviceName, productType: "Heater", intensity: nil, mode: mode, position: nil, temperature: temperature)
    }

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

    internal func isOn() -> Bool {
        return mode == "ON"
    }

    internal mutating func switchMode() {
        mode = mode == "ON" ? "OFF" : "ON"
    }

    internal mutating func setIntensity(to value: Int) {
        intensity = value
    }

    internal mutating func setTemperature(to value: Float) {
        temperature = value
    }

    internal mutating func setPosition(to value: Int) {
        position = value
    }

    internal func getDisplayedTemperature() -> String? {
        guard let temperature = temperature else { return nil }
        let tmpInt = Int(temperature * 2)
        let tmpValue = Float(tmpInt) / 2
        return String(format: "%.1f", tmpValue) + "°C"
    }

}
