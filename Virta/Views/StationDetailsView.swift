//
//  StationDetailsView.swift
//  Virta
//
//  Created by Shaji Shanavas on 24.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI
import MapKit

struct StationDetailsView: View {
    @EnvironmentObject var session: SessionStore
    @State private var showingAlert = false
    let mapManager = MapManager()
    
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
                Button(action: {
                    self.mapManager.showNavigation(name: self.station.name, latitude: self.station.latitude, longitude: self.station.longitude)
                }) {
                    Text("\(station.distance) m")
                    .foregroundColor(.black)
                    Image("icNavigate").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center).padding(.trailing)
                }
                .buttonStyle(PlainButtonStyle())
                
            }
            VStack {
                HStack {
                    Text("Pick a charging point").padding(.bottom, 5)
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
                            
                            Spacer()
                        }
                        Spacer()
                    }.background(Color.gray)
                }
            }.onReceive(session.$serviceFailed, perform: { loginFailed in
                self.showingAlert = loginFailed
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Warning"), message: Text("Failed to get station details"), dismissButton: .default(Text("OK!")) {self.session.serviceFailed = false})
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
