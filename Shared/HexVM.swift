//
//  HexVM.swift
//  Hex
//
//  Created by Chris on 2/20/21.
//

import SwiftUI

enum Turn {
    case one, two
}

class HexVM: ObservableObject {
    @Published var cells: [HexCell]
    @Published var turn = Turn.one
    let size: Int
    
    init(size: Int) {
        self.size = size
        cells = Array.init(repeating: HexCell(), count: size * size)
    }
    
    func toggleTurn() {
        turn = turn == .one ? .two : .one
    }
}
