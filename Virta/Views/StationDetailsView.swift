//
//  StationDetailsView.swift
//  Virta
//
//  Created by Shaji Shanavas on 24.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI

struct StationDetailsView: View {
    @ObservedObject var networkManager = NetworkManager()
    var stationId: Int?
    var body: some View {
        VStack {
            HStack {
                Text(networkManager.station.name)
                Image("logIn").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center)
            }
            Text(networkManager.station.address)
        }.onAppear {
            self.networkManager.getStationDetails(stationId: self.stationId!)
        }
    }
}

struct StationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailsView().environmentObject(SessionStore())
    }
}
