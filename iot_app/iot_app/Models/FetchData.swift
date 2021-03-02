//
//  FetchData.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import Foundation

struct FetchData: Decodable {
    private(set) var devices: [Device]
    private(set) var user: User
}
