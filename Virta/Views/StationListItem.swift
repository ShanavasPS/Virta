//
//  StationListItem.swift
//  Virta
//
//  Created by Shaji Shanavas on 25.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit
struct StationsListItem: View {
    @EnvironmentObject var session: SessionStore
    let mapManager = MapManager()
    
    let station: Station
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text(station.name)
                        Spacer()
                        Button(action: {
                            self.mapManager.showNavigation(name: self.station.name, latitude: self.station.latitude, longitude: self.station.longitude)
                        }) {
                            Text(String(station.distance) + " m")
                            Image("icNavigate").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    HStack {
                        Text(station.address ?? "")
                        Spacer()
                    }
                }
            }
            GridView(station: station)
        }
    }
}



struct StationsListItem_Previews: PreviewProvider {
    static var previews: some View {
        StationsListItem(station: Station()).environmentObject(SessionStore())
    }
}
