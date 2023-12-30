//
//  NetworkMonitor.swift
//  Wonderful Indonesia
//
//  Created by Bryan Andersen on 2023/12/23.
//

import Foundation
import Network

@Observable class NetworkMonitor {
    private let networkMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    var isConnected = true

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: queue)
    }
}
