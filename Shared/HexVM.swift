//
//  HexVM.swift
//  Hex
//
//  Created by Chris on 2/20/21.
//

import SwiftUI
import Combine

class HexVM: ObservableObject {
    var game = HexGame()
    private var anyCancellable: AnyCancellable? = nil
    
    var turn: String {
        if game.win != .empty {
            return "Game Over"
        } else {
            return game.turn == .one ? "Red's Turn" : "Blue's Turn"
        }
    }
    
    @Published var showingWin = false
    
    var winTitle: String {
        switch game.win {
        case .one:
            return "Red won!"
        case .two:
            return "Blue won!"
        case .empty:
            return ""
        }
    }
    
    var cells: [Tile] {
        var tiles = [Tile]()
        for row in game.board {
            for cell in row {
                switch cell.state {
                case .one:
                    tiles.append(Tile(color: .red))
                case .two:
                    tiles.append(Tile(color: .blue))
                case .empty:
                    tiles.append(Tile(color: .gray))
                }
            }
        }
        return tiles
    }

    init() {
        // This forces our viewmodel to fire an objectWillChange even every time game fires objectWillChange.
        // It essentially let you nest ObservableObjects.
        // This is not necessary if the underlying model is a struct instead of a class.
        anyCancellable = game.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }

    func tileTapped(index: Int) {
        let (r, q) = indexToRQ(index: index)
        game.move(r: r, q: q)
        if game.win != .empty {
            showingWin = true
        }
//        dump(game.checkForWin())
//        objectWillChange.send()
    }
    
    func indexToRQ(index: Int) -> (Int, Int) {
        (index / game.size, index % game.size)
    }
    
    func newGame() {
        game.newGame()
    }
}

extension HexVM {
    struct Tile {
        var color: Color
    }
}
