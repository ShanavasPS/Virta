//
//  InfoView.swift
//  Virta
//
//  Created by Shaji Shanavas on 25.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        HStack {
            Image("logIn").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center).padding()
            VStack {
                Text("How to Use")
                Text("We are always here to help")
            }
            Spacer()
            Image("logIn").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center)

        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView().environmentObject(SessionStore())
    }
}
