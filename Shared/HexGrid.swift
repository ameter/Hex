//
//  HexGrid.swift
//  Hex
//
//  Created by Chris on 2/20/21.
//

import SwiftUI

struct Cell {
    enum State {
        case red
        case blue
        case empty
    }

    var state = State.empty
    
    var color: Color {
        switch state {
        case .red:
            return .red
        case .blue:
            return .blue
        case .empty:
            return .gray
        }
    }
}

struct HexGrid: View {
    @State var cells = Array.init(repeating: Cell(), count: 36)
    
    enum Turn {
        case one, two
    }
    
    @State var turn = Turn.one
    
    let cols: Int = 6
    let spacing: CGFloat = 2
    let cellSize = CGSize(width: 50, height: 50)
//    var hexagonWidth: CGFloat { (cellSize.width / 2) * cos(.pi / 6) * 2 }
    var hexagonHeight: CGFloat { (cellSize.height / 2) * cos(.pi / 6) * 2 }
        
    var body: some View {
        let gridItems = Array(repeating: GridItem(.fixed(cellSize.width * 0.75), spacing: spacing), count: cols)

            LazyVGrid(columns: gridItems, spacing: spacing) {
                ForEach(0..<cells.count) { i in
                    VStack(spacing: 0) {
//                        Image("chickenlittle")//"image-\(idx % 15)")
                        Hexagon()
                            .foregroundColor(cells[i].color)
                            .opacity(0.8)
//                            .resizable()
                            .onTapGesture {
                                if cells[i].state == .empty {
                                    cells[i].state = turn == .one ? .blue : .red
                                    toggleTurn()
                                }
                            }
                            .frame(width: cellSize.width, height: cellSize.height)
//                            .clipShape(PolygonShape(sides: 6).rotation(Angle.degrees(90)))
//                            .offset(y: idx % 2 == 0 ? hexagonHeight / 2 + (spacing / 2) : 0)
                            .offset(y: col(i) * (hexagonHeight / 2 + (spacing / 2)))
//                            .offset(x: CGFloat(row(idx)) * (hexagonWidth / 2 + (spacing / 2)))
                            .onTapGesture {
                                print("blah")
                            }
                            //.background(Color.red)
                    }
                    .frame(width: cellSize.width * 0.75, height: hexagonHeight)
//                    .background(Color.yellow)
                }
            }
//            .frame(width: (cellSize.width + spacing) * CGFloat(cols - 1))
            .frame(height: (cellSize.width + spacing) * CGFloat(cols - 1))
//            .background(Color.blue)
            .onAppear {
                for idx in 0...36 {
                    print(row(idx))
                }
            }
    }
    
    func toggleTurn() {
        turn = turn == .one ? .two : .one
    }
    
    func isEvenRow(_ idx: Int) -> Bool {
        (idx / cols) % 2 == 0
    }
    
    func row(_ idx: Int) -> CGFloat {
        CGFloat(idx / cols)
    }
    
    func col(_ idx: Int) -> CGFloat {
        CGFloat(idx % cols)
    }
}

struct HexGrid_Previews: PreviewProvider {
    static var previews: some View {
        HexGrid()
    }
}
