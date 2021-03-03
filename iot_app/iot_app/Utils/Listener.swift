//
//  Listener.swift
//  iot_app
//
//  Created by Aurélien Haie on 03/03/2021.
//

import Foundation

class Listener<T> {

    typealias ListenerCallback = (T) -> Void
    var listener: ListenerCallback?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: ListenerCallback?) {
        self.listener = listener
        listener?(value)
    }

}
