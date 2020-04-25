//
//  Auth.swift
//  Virta
//
//  Created by Shaji Shanavas on 25.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI
import Combine

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? { didSet {self.didChange.send(self) }}
}

struct User {
    var token:String?
    
    init(token:String) {
        self.token = token
    }
}
