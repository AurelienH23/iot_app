//
//  Address.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import Foundation

struct Address: Decodable {
    private let city: String
    private let postalCode: Int
    private let street: String
    private let streetCode: String
    private let country: String
}
