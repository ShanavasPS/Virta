//
//  StationDetailsView.swift
//  Virta
//
//  Created by Shaji Shanavas on 24.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI

struct StationDetailsView: View {
    @EnvironmentObject var session: SessionStore
    var stationId: Int?
    var body: some View {
        VStack {
            HStack {
                Text(session.station.name)
                Image("logIn").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center)
            }
            Text(session.station.address)
            Text("Pick a charging point")
            List(session.station.evses) { evse in
                Text("hello")
            }
            Text("Info and Help").fontWeight(.bold)
            Text(session.station.providers ?? "")
            Text("Provider")
            InfoView()
            InfoView()
            Spacer()
        }.onAppear {
            self.session.getStationDetails(stationId: self.stationId ?? 0)
        }
    }
}

struct StationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailsView().environmentObject(SessionStore())
    }
}
