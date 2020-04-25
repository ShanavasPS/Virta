//
//  PostData.swift
//  Virta
//
//  Created by Shaji Shanavas on 24.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import Foundation

struct Result: Decodable {
    let token: String
}

struct FailedResult: Decodable {
    let status_code: Int
    let message: String
}

struct Connector: Decodable {
    let type: String
    let maxKw: Int
}

struct Evse: Decodable {
    let id: Int
    let groupName: String
    let connectors: [Connector]
}

struct Station: Decodable, Identifiable {
    let id: Int
    let latitude: Double
    let longitude: Double
    let icon: Int
    let name: String
    let city: String
    let address: String
    let provider: String
    let evses: [Evse]
    let isRemoved: Bool
    let isPrivate: Bool
}
