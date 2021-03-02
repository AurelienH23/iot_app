//
//  HomeViewController.swift
//  iot_app
//
//  Created by Aurélien Haie on 01/03/2021.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: View elements

    private let profileButton = RoundedButton()
    private let titleLabel = WelcomeTitle(name: "TEST")

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupViews()
    }

    private func fetchData() {
        let urlString = "http://storage42.com/modulotest/data.json"
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

    private func setupViews() {
        view.backgroundColor = .backgroundColor
        view.addSubviews(profileButton, titleLabel)
        profileButton.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: .topPadding + .mediumSpace, paddingRight: .extraLargeSpace)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 100, paddingLeft: .extraLargeSpace, paddingRight: .extraLargeSpace)
    }

}

struct FetchData: Decodable {
    private let devices: [Device]
    private let user: User
}

struct Device: Decodable {
    private let id: Int
}

struct User: Decodable {
    private let firstName: String
    private let lastName: String
    private let birthDate: Int
    private let address: Address
}

struct Address: Decodable {
    private let city: String
    private let postalCode: Int
    private let street: String
    private let streetCode: String
    private let country: String
}
