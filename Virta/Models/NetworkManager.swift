//
//  NetworkManager.swift
//  Virta
//
//  Created by Shaji Shanavas on 24.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject {
        
    func loginUser(username: String, password: String, completion: @escaping (Swift.Result<Bool, Error>) -> Void) {
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
                            completion(.success(true))
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
