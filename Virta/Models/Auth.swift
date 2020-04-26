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
    
    @Published var accessToken: String? = UserDefaults.standard.string(forKey: "accessToken") {
        didSet {
            UserDefaults.standard.set(self.accessToken, forKey: "accessToken")
            self.didChange.send(self)
        }
    }
    
    @Published var stations = [Station]() { didSet {self.didChange.send(self) }}
    
    @Published var station = StationDetails() { didSet {self.didChange.send(self) }}
    
    @Published var loaderVisible = false { didSet {self.didChange.send(self) }}
    
    func  resetSession() {
        accessToken = nil
    }
    
    func loginUser(username: String, password: String) {
        loaderVisible = true
        networkManager.loginUser(username: username, password: password) { (result) in
            DispatchQueue.main.async {
                self.accessToken = try? result.get()
            }
        }
    }
    
    func getStations(location: CLLocation) {
        self.loaderVisible = true
        networkManager.getStations(location: location) { (result) in
            DispatchQueue.main.async {
                self.loaderVisible = false
                if let stations = try? result.get() {
                    self.stations = stations
                }
            }
        }
    }
    
    func getStationDetails(stationId: Int) {
        loaderVisible = true
        networkManager.getStationDetails(stationId: stationId) { (result) in
            DispatchQueue.main.async {
                self.loaderVisible = false
                if let station = try? result.get() {
                    self.station = station
                }
            }
        }
    }
}
