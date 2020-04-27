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
        ZStack {
            if session.accessToken != nil {
                StationsListView()
            } else {
                LoginView()
            }
            if session.loaderVisible {
                GeometryReader {_ in
                    Loader()
                }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
            }
        }
    }
}

struct AppRootView_Previews: PreviewProvider {
    static var previews: some View {
        AppRootView().environmentObject(SessionStore())
    }
}
