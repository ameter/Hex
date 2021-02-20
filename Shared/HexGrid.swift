//
//  HexGrid.swift
//  Hex
//
//  Created by Chris on 2/20/21.
//

import SwiftUI

struct HexGrid: View {
    let rows: Int
    let columns: Int
    
    var body: some View {
        
        
        
        VStack {
            ForEach(0 ..< rows) { row in
                HStack {
                    ForEach(0 ..< columns) { colmun in
                        Hexagon()
                            .onTapGesture {
                                print("tapped")
                            }
                    }
                }
                .offset(x: CGFloat(row) * 65, y: CGFloat(row) * -150)
//                .position(x: 0.0, y: CGFloat(row) * 200.0)
            }
        }
//        .frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct HexGrid_Previews: PreviewProvider {
    static var previews: some View {
        HexGrid(rows: 3, columns: 3)
    }
}
