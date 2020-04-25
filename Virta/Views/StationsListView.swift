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
    @ObservedObject var networkManager = NetworkManager()
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
                List(networkManager.stations) { station in
                    NavigationLink(destination: StationDetailsView(stationId: station.id) ) {
                        StationsListItem(station: station)
                    }
                }
            }.navigationBarTitle("Nearby")
        }.onAppear {
            self.networkManager.getStations()
        }
    }
}

struct StationsListView_Previews: PreviewProvider {
    static var previews: some View {
        StationsListView()
    }
}
