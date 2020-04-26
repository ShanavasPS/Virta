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
                    .fontWeight(.bold)
                Spacer()
                Image("icX").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center)
            }.padding(.leading)
            HStack {
                Text(session.station.address)
                Spacer()
            }.padding(.leading)
            HStack {
                Spacer()
                Text("500m")
                Image("icNavigate").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center).padding(.trailing)
            }
            VStack {
                HStack {
                    Text("Pick a charging point")
                    Spacer()
                }.padding(.leading)
                List(session.station.evses) { evse in
                    Text(String(describing: evse.id ?? 0))
                }.colorMultiply(Color.gray).padding(.top)
            }
            HStack {
                Text("Info and Help").fontWeight(.bold)
                Spacer()
            }.padding()
            
            HStack {
                Text(session.station.providers ?? "")
                Spacer()
            }.padding(.leading)
            
            HStack {
                Text("Provider")
                Spacer()
            }.padding(.leading)
            
            VStack {
                InfoView(image: "icInfo", title: "How to Use", subtitle: "We are always here to help")
                InfoView(image: "icFeedbackSad", title: "Report Issue", subtitle: "Something not perfect")
            }
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
