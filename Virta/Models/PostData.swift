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
