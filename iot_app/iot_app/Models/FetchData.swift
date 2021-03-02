//
//  FetchData.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import Foundation

struct FetchData: Decodable {
    private let devices: [Device]
    private let user: User
}
