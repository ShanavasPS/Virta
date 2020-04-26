//
//  Auth.swift
//  Virta
//
//  Created by Shaji Shanavas on 25.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI
import Combine
import CoreLocation

class SessionStore: ObservableObject {
    @ObservedObject var networkManager = NetworkManager()
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? { didSet {self.didChange.send(self) }}
    
    @Published var accessToken: String? = UserDefaults.standard.string(forKey: "accessToken") {
        didSet {
            UserDefaults.standard.set(self.accessToken, forKey: "accessToken")
            self.didChange.send(self)
        }
    }
    
    @Published var stations = [Station]() { didSet {self.didChange.send(self) }}
    
    @Published var station = StationDetails() { didSet {self.didChange.send(self) }}

    var selectedStation: Station?
    
    func  resetSession() {
        accessToken = nil
    }
    
    func loginUser(username: String, password: String) {
        networkManager.loginUser(username: username, password: password) { (result) in
            DispatchQueue.main.async {
                self.accessToken = try? result.get()
            }
        }
    }
    
    func getStations(location: CLLocation) {
        networkManager.getStations(location: location) { (result) in
            if let stations = try? result.get() {
                DispatchQueue.main.async {
                    self.stations = stations
                }
            }
        }
    }
    
    func getStationDetails(stationId: Int) {
        networkManager.getStationDetails(stationId: stationId) { (result) in
            if let station = try? result.get() {
                DispatchQueue.main.async {
                    self.station = station
                }
            }
        }
    }
}

struct User {
    var token:String?
    
    init(token:String) {
        self.token = token
    }
}
