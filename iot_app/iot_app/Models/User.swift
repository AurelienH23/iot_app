//
//  User.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import Foundation

struct User: Decodable {
    private let firstName: String
    private let lastName: String
    private let birthDate: Int
    private let address: Address

    internal func nameToDisplay() -> String {
        return firstName
    }
}
