//
//  DirectionsView.swift
//  Virta
//
//  Created by Shaji Shanavas on 27.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI

struct DirectionsView: View {
    @EnvironmentObject var session: SessionStore
    let mapManager = MapManager()

    let name:String
    let latitude: Double
    let longitude: Double
    let distance: Int
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                self.mapManager.showNavigation(name: self.name, latitude: self.latitude, longitude: self.longitude)
            }) {
                Text("\(distance) m")
                    .foregroundColor(.black)
                Image("icNavigate").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center).padding(.trailing)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct DirectionsView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsView(name: "", latitude: 0.0, longitude: 0.0, distance: 0).environmentObject(SessionStore())
    }
}

