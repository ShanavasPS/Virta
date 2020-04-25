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

struct Pricing: Decodable {
    let name: String
    let priceCents: Double
    let currency: String
    let priceCentsWithoutVat: Double
    let priceCentsVat: Double
}

struct EvseDetails: Decodable {
    let id: Int
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
    let oneTimePricingRatio: Int
    let minutesWithoutTimeCharge: Int
    let isFree: Bool
    let evseId: String
}

struct ConnectorDetails: Decodable {
    let connectorID: Int
    let type: String
    let maxKwh: Int
    let maxKw: Int
    let currentType: String
}

struct Station: Decodable, Identifiable {
    let id: Int
    let latitude: Double
    let longitude: Double
    let icon: Int?
    let name: String
    let city: String
    let address: String
    let provider: String
    let evses: [Evse]
    let isRemoved: Bool
    let isPrivate: Bool
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
}
