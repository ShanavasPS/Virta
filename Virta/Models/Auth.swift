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
    
    @Published var loginFailed = false { didSet {self.didChange.send(self) }}
    
    func  resetSession() {
        accessToken = nil
    }
    
    func loginUser(username: String, password: String) {
        loaderVisible = true
        networkManager.loginUser(username: username, password: password) { (result) in
            DispatchQueue.main.async {
                if let accessToken = try? result.get() {
                    self.accessToken = accessToken
                } else {
                    self.loginFailed = true
                    self.loaderVisible = false
                }
            }
        }
    }
    
    func getStations(location: CLLocation) {
        self.loaderVisible = true
        networkManager.getStations(location: location) { (result) in
            DispatchQueue.main.async {
                self.loaderVisible = false
                if let stations = try? result.get() {
                    self.updateDistance(stations: stations, location: location)
                }
            }
        }
    }
    
    func updateDistance(stations:[Station], location: CLLocation) {
        for index in 0..<stations.count {
            stations[index].distance = Int(location.distance(from: CLLocation(latitude: stations[index].latitude, longitude: stations[index].longitude)).rounded())
        }
        
        self.stations = stations.sorted { $0.distance < $1.distance }
    }
    
    func getStationDetails(stationId: Int) {
        station = StationDetails()
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
