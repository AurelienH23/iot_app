//
//  HomeViewModel.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import Foundation

class HomeViewModel {

    // MARK: Properties

    internal var filters: Listener<Set> = Listener(Set<Filter>())

    // MARK: Custom funcs

    internal func updateFilters(with selectedFilter: Filter, if isSelected: Bool) {
        if isSelected {
            filters.value.insert(selectedFilter)
        } else {
            filters.value.remove(selectedFilter)
        }
    }

    // MARK: Collection View

    internal func numberOfItems() -> Int {
        if filters.value.isEmpty {
            return DataManager.shared.devices.count
        } else {
            let filteredDevices = DataManager.shared.devices.filter { (device) -> Bool in
                return self.filters.value.contains(Filter.getFilter(associatedTo: device.productType))
            }
            return filteredDevices.count
        }
    }

    internal func getDevice(at index: Int) -> Device {
        var devices = DataManager.shared.devices
        if !filters.value.isEmpty {
            devices = DataManager.shared.devices.filter { (device) -> Bool in
                let associatedFilter = Filter.getFilter(associatedTo: device.productType)
                return self.filters.value.contains(associatedFilter)
            }
        }
        return devices[index]
    }

}
