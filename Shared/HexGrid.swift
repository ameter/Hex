//
//  HexGrid.swift
//  Hex
//
//  Created by Chris on 2/20/21.
//

import SwiftUI

struct HexGrid: View {
    @ObservedObject var hvm: HexVM
    
    let cols: Int
    let spacing: CGFloat = 2
    let cellSize = CGSize(width: 50, height: 50)
    var hexagonHeight: CGFloat { (cellSize.height / 2) * cos(.pi / 6) * 2 }
    
    init(hexVM: HexVM) {
        self.hvm = hexVM
        cols = hexVM.size
    }
    
    var body: some View {
        let gridItems = Array(repeating: GridItem(.fixed(cellSize.width * 0.75), spacing: spacing), count: cols)
        LazyVGrid(columns: gridItems, spacing: spacing) {
            ForEach(0..<hvm.cells.count) { i in
                ZStack {
                    
                    Hexagon()
                        .foregroundColor(hvm.cells[i].color)
                        .opacity(0.8)
                        .onTapGesture {
                            if hvm.cells[i].state == .empty {
                                hvm.cells[i].state = hvm.turn == .one ? .blue : .red
                                hvm.toggleTurn()
                            }
                        }
                        .frame(width: cellSize.width, height: cellSize.height)
                        .offset(y: col(i) * (hexagonHeight / 2 + (spacing / 2)))
                        .frame(width: cellSize.width * 0.75, height: hexagonHeight)
                }
            }
        }
        .frame(width: (cellSize.width + spacing) * CGFloat(cols - 1))
        .frame(height: (hexagonHeight) * CGFloat(cols) * 1.5)
    }
    
    func isEvenRow(_ idx: Int) -> Bool {
        (idx / cols) % 2 == 0
    }
    
    func row(_ idx: Int) -> CGFloat {
        CGFloat(idx / cols)
    }
    
    func col(_ idx: Int) -> CGFloat {
        CGFloat(Double(idx % cols) - Double(cols) / 2.5)
    }
}

struct HexGrid_Previews: PreviewProvider {
    static var previews: some View {
        HexGrid(hexVM: HexVM(size: 6))
    }
}
