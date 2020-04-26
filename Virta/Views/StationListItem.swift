//
//  StationListItem.swift
//  Virta
//
//  Created by Shaji Shanavas on 25.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI


struct StationsListItem: View {
    @EnvironmentObject var session: SessionStore

    let station: Station
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(station.name)
                    Text(station.address ?? "")
                }.padding(20)
                
                HStack {
                    Text("80m")
                    Image("icNavigate").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .trailing)
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
