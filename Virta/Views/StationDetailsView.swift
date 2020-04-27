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
    var station: Station
    var body: some View {
        VStack {
            HStack {
                Text(station.name)
                    .fontWeight(.bold)
                Spacer()
                Image("icX").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center).padding(.trailing)
            }.padding(.leading)
            HStack {
                Text(station.address ?? "")
                Spacer()
            }.padding(.leading)
            HStack {
                Spacer()
                Text("\(station.distance) m")
                Image("icNavigate").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center).padding(.trailing)
            }
            VStack {
                HStack {
                    Text("Pick a charging point")
                    Spacer()
                }.padding(.leading)
                if !session.station.evses.isEmpty {
                    List(session.station.evses) { evse in
                        ZStack {
                            HStack {
                                Text(String(describing: evse.id ?? 0))
                                    .foregroundColor(.green)
                                    .padding(8)
                                    .font(.system(size: 20))
                                    .border(Color.green, width: 5).padding(.leading)
                                Spacer()
                            }
                        }
                    }.colorMultiply(Color.gray).padding(.top)
                } else {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            if session.station.id != nil {
                                Text("Loading points....")
                            } else {
                                 Text("Failed to load points....")
                            }
                            Spacer()
                        }
                        Spacer()
                    }.background(Color.gray)
                }
            }
            Spacer()
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
            self.session.getStationDetails(stationId: self.station.id)
        }
    }
}

struct StationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailsView(station: Station()).environmentObject(SessionStore())
    }
}
