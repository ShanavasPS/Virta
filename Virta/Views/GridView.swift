//
//  GridView.swift
//  Virta
//
//  Created by Shaji Shanavas on 26.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI

struct GridView : View {
    var persons = [1,2,3,4,5,6,7,8]
    let items: [String] = ["1", "2", "3", "4", "5"]
    var cols = 3
    var isLastRowFull: Bool {
        return (items.count % self.cols == 0)
    }
    var rowCount: Int {
        return items.count / self.cols
    }
    var rows: Int {
        return isLastRowFull ? rowCount: rowCount + 1
    }
    
    var lastRowCount: Int {
        return isLastRowFull ? cols : items.count % self.cols
    }
    
    var body : some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    ForEach(0..<self.rows) { row in
                        HStack {
                            ForEach(0..<(row == self.rows - 1 ? self.lastRowCount: 3)) { column in
                                ConnectorView()
                            }
                        }
                    }
                }
            }.background(Color.white)
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
