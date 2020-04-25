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

    var body: some View {
        NavigationView {
            VStack {
                Text("Stations List View").navigationBarTitle("Nearby")
                NavigationLink(destination: StationDetailsView() )
                { Text("Push to StationDetailsView.") }
                Button(action: {
                    self.session.resetSession()
                }, label: { Text("Logout")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.horizontal) })
                    .background(Color.yellow)
            }
        }
    }
}

struct StationsListView_Previews: PreviewProvider {
    static var previews: some View {
        StationsListView().environmentObject(SessionStore())
    }
}


