//
//  DataManager.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import Foundation

class DataManager {

    // MARK: Properties

    private(set) var user: User? = nil {
        didSet {
            userObservers.forEach({$0(user)})
        }
    }

    private(set) var devices = [Device]() {
        didSet {
            devicesObservers.forEach({$0(devices)})
        }
    }

    internal var userObservers = [(User?) -> Void]()
    internal var devicesObservers = [([Device]) -> Void]()

    // MARK: Lifecycle

    static let shared = DataManager()

    // MARK: Custom funcs

    internal func startup() {
        print("Start up DataManager")
        Network.session.fetchData { result in
            switch result {
            case .success(let data):
                self.user = data.user
                self.devices = data.devices
            case .failure(let err):
                print("Failed fetching data with err:", err)
            }
        }
    }

}
