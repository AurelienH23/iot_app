//
//  DataManager.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import UIKit
import CoreData

class DataManager {

    // MARK: Properties

    private(set) var user: User? = nil
    private(set) var devices = [Device]()

    // MARK: Lifecycle

    static let shared = DataManager()

    // MARK: Custom funcs

    private func saveContext(with message: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            try managedContext.save()
        } catch {
            print(message)
        }
    }

    internal func startup() {
        print("Start up DataManager")
        if isUserSavedInLocal() {
            fetchLocalData()
        } else {
            fetchDataOnline()
        }
    }

    internal func updateUser(firstname: String, lastname: String) {
        user?.setFirstname(firstname)
        user?.setLastname(lastname)
        guard let user = user else { return }
        updateLocalUser(with: user)
        NotificationCenter.default.post(name: .userDidChange, object: nil)
    }

    internal func update(_ device: Device) {
        updateLocalDevice(device)
        guard let index = devices.firstIndex(where: {$0.id == device.id}) else { return }
        devices.remove(at: index)
        devices.insert(device, at: index)
    }

    private func resetAllRecords(in entity : String) {
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }

    private func isUserSavedInLocal() -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserEntity")
        do {
            let fetchedObjects = try managedContext.fetch(fetchRequest)
            return fetchedObjects.count > 0
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }

    // MARK: - Fetch data

    private func fetchLocalData() {
        fetchLocalUser()
        fetchLocalDevices()
        NotificationCenter.default.post(name: .didLoadData, object: nil)
    }

    private func fetchLocalUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserEntity")
        do {
            let fetchedObjects = try managedContext.fetch(fetchRequest)
            if let user = fetchedObjects.first,
               let firstname = user.value(forKey: "firstname") as? String,
               let lastname = user.value(forKey: "lastname") as? String,
               let birthdate = user.value(forKey: "birthdate") as? Int,
               let streetCode = user.value(forKey: "streetCode") as? String,
               let street = user.value(forKey: "street") as? String,
               let postalCode = user.value(forKey: "postalCode") as? Int,
               let city = user.value(forKey: "city") as? String,
               let country = user.value(forKey: "country") as? String {
                let address = Address(city: city, postalCode: postalCode, street: street, streetCode: streetCode, country: country)
                let savedUser = User(firstName: firstname, lastName: lastname, birthDate: birthdate, address: address)
                self.user = savedUser
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    private func fetchLocalDevices() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DeviceEntity")
        do {
            let fetchedObjects = try managedContext.fetch(fetchRequest)
            fetchedObjects.forEach { object in
                if let id = object.value(forKey: "id") as? Int,
                   let deviceName = object.value(forKey: "deviceName") as? String,
                   let productType = object.value(forKey: "productType") as? String {
                    switch productType {
                    case "Light":
                        guard let intensity = object.value(forKey: "intensity") as? Int else { return }
                        guard let mode = object.value(forKey: "mode") as? String else { return }
                        let savedDevice = Device.createLight(id: id, deviceName: deviceName, intensity: intensity, mode: mode)
                        devices.append(savedDevice)
                    case "RollerShutter":
                        guard let position = object.value(forKey: "position") as? Int else { return }
                        let savedDevice = Device.createRollerShutter(id: id, deviceName: deviceName, position: position)
                        devices.append(savedDevice)
                    case "Heater":
                        guard let temperature = object.value(forKey: "temperature") as? Float else { return }
                        guard let mode = object.value(forKey: "mode") as? String else { return }
                        let savedDevice = Device.createHeater(id: id, deviceName: deviceName, mode: mode, temperature: temperature)
                        devices.append(savedDevice)
                    default:
                        break
                    }
                }
            }
        } catch let error as NSError {
            print("Could not save device. \(error), \(error.userInfo)")
        }
    }

    private func fetchDataOnline() {
        Network.session.fetchData { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.saveUser(data.user)
                    self.saveDevices(data.devices)
                    NotificationCenter.default.post(name: .didLoadData, object: nil)
                }
            case .failure(let err):
                print("Failed fetching data with err:", err)
                NotificationCenter.default.post(name: .failedLoadingData, object: nil)
            }
        }
    }

    // MARK: - Save data

    private func saveUser(_ user: User) {
        self.user = user
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: managedContext) else { return }
        let savedUser = NSManagedObject(entity: entity, insertInto: managedContext)
        savedUser.setValue(user.firstName, forKey: "firstname")
        savedUser.setValue(user.lastName, forKey: "lastname")
        savedUser.setValue(user.birthDate, forKey: "birthdate")
        savedUser.setValue(user.address.streetCode, forKey: "streetCode")
        savedUser.setValue(user.address.street, forKey: "street")
        savedUser.setValue(user.address.postalCode, forKey: "postalCode")
        savedUser.setValue(user.address.city, forKey: "city")
        savedUser.setValue(user.address.country, forKey: "country")

        saveContext(with: "Failed saving user locally")
    }

    private func saveDevices(_ devices: [Device]) {
        self.devices = devices
        devices.forEach({saveDevice($0)})
    }

    private func saveDevice(_ device: Device) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "DeviceEntity", in: managedContext) else { return }
        let savedDevice = NSManagedObject(entity: entity, insertInto: managedContext)
        savedDevice.setValue(device.id, forKey: "id")
        savedDevice.setValue(device.deviceName, forKey: "deviceName")
        savedDevice.setValue(device.productType, forKey: "productType")

        switch device.productType {
        case "Light":
            savedDevice.setValue(device.intensity, forKey: "intensity")
            savedDevice.setValue(device.mode, forKey: "mode")
        case "RollerShutter":
            savedDevice.setValue(device.position, forKey: "position")
        case "Heater":
            savedDevice.setValue(device.temperature, forKey: "temperature")
            savedDevice.setValue(device.mode, forKey: "mode")
        default:
            break
        }

        saveContext(with: "Failed saving device locally")
    }

    // MARK: - Update data

    private func updateLocalDevice(_ device: Device) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DeviceEntity")
        let predicate = NSPredicate(format: "id == %d", device.id)
        fetchRequest.predicate = predicate
        do {
            let fetchedObjects = try managedContext.fetch(fetchRequest)
            if let fetchdedDevice = fetchedObjects.first {
                switch device.productType {
                case "Light":
                    fetchdedDevice.setValue(device.intensity, forKey: "intensity")
                    fetchdedDevice.setValue(device.mode, forKey: "mode")
                case "RollerShutter":
                    fetchdedDevice.setValue(device.position, forKey: "position")
                case "Heater":
                    fetchdedDevice.setValue(device.temperature, forKey: "temperature")
                    fetchdedDevice.setValue(device.mode, forKey: "mode")
                default:
                    break
                }

                saveContext(with: "Failed updating data locally")
            }
        } catch {
            print("Failed fetching data for updating")
        }
    }

    private func updateLocalUser(with user: User) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserEntity")
        do {
            let fetchedObjects = try managedContext.fetch(fetchRequest)
            if let fetchdedUser = fetchedObjects.first {
                fetchdedUser.setValue(user.firstName, forKey: "firstname")
                fetchdedUser.setValue(user.lastName, forKey: "lastname")
                saveContext(with: "Failed updating data locally")
            }
        } catch {
            print("Failed fetching data for updating")
        }
    }

    internal func delete(_ device: Device, completion: @escaping () -> Void) {
        deleteLocalDevice(device)
        guard let index = devices.firstIndex(where: {$0.id == device.id}) else { return }
        devices.remove(at: index)
        completion()
    }

    private func deleteLocalDevice(_ device: Device) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DeviceEntity")
        let predicate = NSPredicate(format: "id == %d", device.id)
        fetchRequest.predicate = predicate
        do {
            let fetchedDevice = try managedContext.fetch(fetchRequest)
            guard let deviceToDelete = fetchedDevice.first else { return }
            managedContext.delete(deviceToDelete)
            saveContext(with: "Failed deleting device")
        } catch {
            print("Failed fetching data for updating")
        }
    }

}
