//
//  Network.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import Foundation

enum NetworkError: String, Error {
    case fetchingData
    case unavailableData
    case decodingData
}

class Network {

    // MARK: Properties

    private let dataEndpoint = "http://storage42.com/modulotest/data.json"

    // MARK: Lifecycle

    static let session = Network()

    // MARK: Custom funcs

    internal func fetchData(completed: @escaping (Result<FetchData, NetworkError>) -> Void) {
        guard let url = URL(string: dataEndpoint) else { return }
        getData(at: url, decodedAs: FetchData.self, completed: completed)
    }

    private func getData<T: Decodable>(at url: URL, decodedAs object: T.Type, completed: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Error while getting data:", err)
                completed(.failure(.fetchingData))
                return
            }

            print("Successfully fetched data")
            guard let data = data else {
                completed(.failure(.unavailableData))
                return
            }

            do {
                let jsonData = try JSONDecoder().decode(object, from: data)
                completed(.success(jsonData))
            } catch {
                print("Failed decoding data")
                completed(.failure(.decodingData))
            }
        }.resume()
    }

}
