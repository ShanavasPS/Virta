//
//  ConnectorView.swift
//  Virta
//
//  Created by Shaji Shanavas on 26.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI

struct ConnectorView: View {
        
    var body: some View {
        HStack {
            VStack {
                Image("icType2").resizable().aspectRatio(contentMode: .fill).frame(width: 40, height: 40, alignment: .center)
                Text("x2")
            }
            VStack {
                Text("22")
                    .fontWeight(.bold)
                    .font(.system(size: 30))
                Text("kW")
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
            }
        }
        
    }
}

struct ConnectorView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectorView()
    }
}
