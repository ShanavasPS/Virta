//
//  AppRootView.swift
//  Virta
//
//  Created by Shaji Shanavas on 25.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI

struct AppRootView: View {

    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        Group {
            if session.session != nil {
                StationsListView()
            } else {
                LoginView()
            }
        }
    }
}

struct AppRootView_Previews: PreviewProvider {
    static var previews: some View {
        AppRootView().environmentObject(SessionStore())
    }
}
