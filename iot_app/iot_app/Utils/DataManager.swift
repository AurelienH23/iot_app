//
//  DataManager.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import Foundation

class DataManager {

    // MARK: Properties

    private(set) var user: User? = nil
    private(set) var devices = [Device]()

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
                NotificationCenter.default.post(name: .didLoadData, object: nil)
            case .failure(let err):
                print("Failed fetching data with err:", err)
                NotificationCenter.default.post(name: .failedLoadingData, object: nil)
            }
        }
    }

}
