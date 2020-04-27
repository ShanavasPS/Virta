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
    let image:String
    let title: String
    let subtitle: String
    var body: some View {
        HStack {
            Image(image).resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center).padding(.leading)
            VStack {
                LeftAlignedTextView(text: title)
                LeftAlignedTextView(text: subtitle)
            }
            Spacer()
            Image("icChevronRight").resizable().aspectRatio(contentMode: .fit).frame(width: 25, height: 25, alignment: .center).padding(.trailing)
            
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(image: "", title: "", subtitle: "").environmentObject(SessionStore())
    }
}
