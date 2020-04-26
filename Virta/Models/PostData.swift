//
//  PostData.swift
//  Virta
//
//  Created by Shaji Shanavas on 24.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import Foundation

struct LoginData: Decodable {
    let token: String
}

struct Connector: Decodable {
    let type: String
    let maxKw: Int
    init() {
        type = ""
        maxKw = 0
    }
}

struct Evse: Decodable {
    let id: String?
    let groupName: String
    let connectors: [Connector]
    
    private enum CodingKeys: String, CodingKey {
        case id, groupName, connectors
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        groupName = try container.decode(String.self, forKey: .groupName)
        connectors = try container.decode([Connector].self, forKey: .connectors)
        if let value = try? container.decode(Int.self, forKey: .id) {
            id = String(value)
        } else {
            id = try container.decode(String.self, forKey: .id)
        }
    }
}

struct Pricing: Decodable {
    let name: String
    let priceCents: Double
    let currency: String
    let priceCentsWithoutVat: Double
    let priceCentsVat: Double
}

struct EvseDetails: Decodable, Identifiable {
    let id: Int?
    let connectors: [ConnectorDetails]
    let available: Bool
    let reservable: Bool
    let reserved: Bool
    let occupied: Bool
    let isV2G: Bool
    let currency: String
    let pricing: [Pricing]
    let oneTimePayment: Bool
    let oneTimePaymentInAppEnabled: Bool
    let status: Int
    let oneTimeMinimum: Int
    let oneTimePricing: [Pricing]
    let oneTimePricingRatio: Double
    let minutesWithoutTimeCharge: Int
    let isFree: Bool
    let evseId: String
}

struct ConnectorDetails: Decodable {
    let connectorID: Int
    let type: String
    let maxKwh: Double
    let maxKw: Double
    let currentType: String
}

struct Station: Decodable, Identifiable {
    let id: Int
    let latitude: Double
    let longitude: Double
    let icon: Int?
    let name: String
    let city: String
    let address: String?
    let provider: String
    let evses: [Evse]
    let isRemoved: Bool
    let isPrivate: Bool
    
    init() {
        id = 0
        latitude = 0.0
        longitude = 0.0
        icon = 0
        name = ""
        city = ""
        address = ""
        provider = ""
        evses = []
        isRemoved = false
        isPrivate = false
    }
}

struct StationDetails: Decodable, Identifiable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let icon: Int?
    let address: String
    let city: String
    let openHours: String?
    let providers: String?
    let evses: [EvseDetails]
    
    init() {
        id = 0
        name = ""
        latitude = 0.0
        longitude = 0.0
        icon = 0
        address = ""
        city = ""
        openHours = ""
        providers = ""
        evses = []
    }
}
