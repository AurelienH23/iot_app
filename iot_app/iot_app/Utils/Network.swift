//
//  Network.swift
//  iot_app
//
//  Created by Aurélien Haie on 02/03/2021.
//

import Foundation

class Network {

    // MARK: Properties

    private let urlString = "http://storage42.com/modulotest/data.json"

    // MARK: Lifecycle

    static let session = Network()

    // MARK: Custom funcs

    internal func fetchData() {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed fetching data with err:", err)
                return
            }
            print("Successfully fetched data", data)
            guard let data = data else { return }

            do {
                let jsonData = try JSONDecoder().decode(FetchData.self, from: data)
                print(jsonData)
            } catch {
                print("Failed decoding data into FetchData object")
            }
        }.resume()
    }

}
