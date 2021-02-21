//
//  HexCell.swift
//  Hex
//
//  Created by Chris on 2/20/21.
//

import SwiftUI

struct HexCell {
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
