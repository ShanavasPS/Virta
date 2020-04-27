//
//  LeftAlignedTextView.swift
//  Virta
//
//  Created by Shaji Shanavas on 27.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI

struct LeftAlignedTextView: View {
    @EnvironmentObject var session: SessionStore
    let text:String
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
        }.padding(.leading)
    }
}

struct LeftAlignedTextView_Previews: PreviewProvider {
    static var previews: some View {
        LeftAlignedTextView(text: "").environmentObject(SessionStore())
    }
}
