//
//  LeftAlignedBoldTextView.swift
//  Virta
//
//  Created by Shaji Shanavas on 27.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI

struct LeftAlignedBoldTextView: View {
    @EnvironmentObject var session: SessionStore
    let text:String
    
    var body: some View {
        HStack {
            Text(text).fontWeight(.bold)
            Spacer()
        }.padding(.leading)
    }
}

struct LeftAlignedBoldTextView_Previews: PreviewProvider {
    static var previews: some View {
        LeftAlignedBoldTextView(text: "").environmentObject(SessionStore())
    }
}
