//
//  GridView.swift
//  Virta
//
//  Created by Shaji Shanavas on 26.4.2020.
//  Copyright © 2020 Shaji Shanavas. All rights reserved.
//

import SwiftUI

struct GridView : View {
    let station: Station
    var items: [Connector] {
        return station.evses.first?.connectors ?? [Connector]()
    }
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
        Group {
            VStack {
                ForEach(0..<self.rows) { row in
                    HStack {
                        ForEach(0..<(row == self.rows - 1 ? self.lastRowCount: 3)) { column in
                            ConnectorView(connectors: self.items, row: row, col: column)
                        }
                    }
                }
            }.background(Color.white)
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(station: Station())
    }
}
