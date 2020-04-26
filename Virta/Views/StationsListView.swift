//
//  StationsListView.swift
//  Virta
//
//  Created by Shaji Shanavas on 24.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI

struct StationsListView: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.session.resetSession()
                }, label: { Text("Logout")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal) })
                    .background(Color.yellow)
                
                List(session.stations) { station in
                    NavigationLink(destination: StationDetailsView(stationId: station.id) ) {
                        StationsListItem(station: station)
                    }
                }.onReceive(locationManager.$location, perform: { loc in
                        if let location = loc {
                            self.session.getStations(location: location)
                        }
                })
            }.navigationBarTitle("Nearby")
        }
    }
}

struct StationsListView_Previews: PreviewProvider {
    static var previews: some View {
        StationsListView()
    }
}
