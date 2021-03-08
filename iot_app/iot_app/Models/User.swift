//
//  User.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import Foundation

struct User: Decodable {
    private(set) var firstName: String
    private(set) var lastName: String
    private(set) var birthDate: Int
    private(set) var address: Address

    internal func nameToDisplay() -> String {
        return firstName
    }

    internal func fullName() -> String {
        return firstName + " " + lastName
    }

    internal func birthdateToString() -> String {
        let dateOfbirth = Date(timeIntervalSinceReferenceDate: TimeInterval(birthDate))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        return formatter.string(from: dateOfbirth)
    }

    internal func getAddress() -> String {
        return address.fullAddress()
    }

}
