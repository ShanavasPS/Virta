//
//  StationsListView.swift
//  Virta
//
//  Created by Shaji Shanavas on 24.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI
import CoreLocation

struct StationsListView: View {
    @EnvironmentObject var session: SessionStore
    @ObservedObject var locationManager = LocationManager()
    
    var body: some View {
        NavigationView {
            VStack {
                if !session.stations.isEmpty {
                    List(session.stations) { station in
                        NavigationLink(destination: StationDetailsView(stationId: station.id, distance: station.distance) ) {
                            StationsListItem(station: station)
                        }
                    }.padding(.trailing)
                }
                Spacer()
                Button(action: {
                    self.session.resetSession()
                }, label: { Text("Logout")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal) })
                    .background(Color.yellow)
            }
            .onReceive(locationManager.$location, perform: { loc in
                    if let location = loc {
                        self.session.getStations(location: location)
                    }
            })
            .onAppear {
                self.locationManager.fetchLocation()
            }.navigationBarTitle("Nearby")
        }
    }
}

struct StationsListView_Previews: PreviewProvider {
    static var previews: some View {
        StationsListView().environmentObject(SessionStore())
    }
}
