//
//  Address.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import Foundation

struct Address: Decodable {
    private(set) var city: String
    private(set) var postalCode: Int
    private(set) var street: String
    private(set) var streetCode: String
    private(set) var country: String
}
