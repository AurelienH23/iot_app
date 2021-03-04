//
//  Filter.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import Foundation

enum Filter {
    case light
    case rollerShutter
    case heater

    internal func displayedName() -> String {
        switch self {
        case .light:
            return "Lights"
        case .rollerShutter:
            return "Roller shutters"
        case .heater:
            return "Heaters"
        }
    }

    static func getFilter(associatedTo productType: String) -> Filter {
        let associations: [String: Filter] = ["Light": .light,
                                              "RollerShutter": .rollerShutter,
                                              "Heater": .heater]
        return associations[productType]!
    }

}
