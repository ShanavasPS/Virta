//
//  NetworkManager.swift
//  Virta
//
//  Created by Shaji Shanavas on 24.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI

class NetworkManager: ObservableObject {
    
    @EnvironmentObject var session: SessionStore
    @Published var stations = [Station]()
    @Published var station = StationDetails(id: 0, name: "", latitude: 0.0, longitude: 0.0, icon: 0, address: "", city: "", openHours: "", providers: "", evses: [])
    
    func loginUser(username: String, password: String, completion: @escaping (Swift.Result<String, Error>) -> Void) {
        if let url = URL(string: "https://apitest.virta.fi/v4/auth") {
            var mutableRequest = URLRequest(url: url)
            mutableRequest.httpMethod = "POST"
            let encodedPassword = password.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            let data = "email=\(username)&code=\(encodedPassword ?? "")".data(using: .utf8)
            mutableRequest.httpBody = data
            mutableRequest.cachePolicy = .reloadIgnoringLocalCacheData
            mutableRequest.timeoutInterval = 10
            let task = URLSession.shared.dataTask(with: mutableRequest) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let result = try decoder.decode(Result.self, from: safeData)
                            completion(.success(result.token))
                        } catch {
                            print(error)
                            do {
                                let failedResult = try decoder.decode(FailedResult.self, from: safeData)
                                print(failedResult)
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func getStations() {
        if let url = URL(string: "https://apitest.virta.fi/v4/stations?from=160&limit=10") {
            var mutableRequest = URLRequest(url: url)
            mutableRequest.httpMethod = "GET"
            mutableRequest.cachePolicy = .reloadIgnoringLocalCacheData
            mutableRequest.timeoutInterval = 10
            let task = URLSession.shared.dataTask(with: mutableRequest) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let stations = try decoder.decode([Station].self, from: safeData)
                            DispatchQueue.main.async {
                                self.stations = stations
                            }
                        } catch {
                            print(error)
                            do {
                                let failedResult = try decoder.decode(FailedResult.self, from: safeData)
                                print(failedResult)
                            } catch {
                                print(error)
                            }
                        }
                    }
                } 
            }
            task.resume()
        }
    }
    
    func getStationDetails(stationId: Int) {
        if let url = URL(string: "https://apitest.virta.fi/v4/stations/\(stationId)") {
            var mutableRequest = URLRequest(url: url)
            mutableRequest.httpMethod = "GET"
            mutableRequest.cachePolicy = .reloadIgnoringLocalCacheData
            mutableRequest.timeoutInterval = 10
            let task = URLSession.shared.dataTask(with: mutableRequest) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let station = try decoder.decode(StationDetails.self, from: safeData)
                            print(station)
                            DispatchQueue.main.async {
                                self.station = station
                            }
                        } catch {
                            print(error)
                            do {
                                let failedResult = try decoder.decode(FailedResult.self, from: safeData)
                                print(failedResult)
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
