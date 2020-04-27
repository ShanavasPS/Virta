//
//  StationListItem.swift
//  Virta
//
//  Created by Shaji Shanavas on 25.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI
import CoreLocation

struct StationsListItem: View {
    @EnvironmentObject var session: SessionStore
    
    let station: Station
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text(station.name)
                        DirectionsView(name: self.station.name, latitude: self.station.latitude, longitude: self.station.longitude, distance: self.station.distance)
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
