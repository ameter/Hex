//
//  HexGame.swift
//  Hex
//
//  Created by Chris on 2/20/21.
//

// lots of info here: https://www.redblobgames.com/grids/hexagons/

import Foundation

class HexGame: ObservableObject {
    @Published var size: Int {
        didSet {
            print("boom")
            newGame()
//            board = Array(repeating: Array(repeating: Cell(), count: size), count: size)
        }
    }
    var win: Player {
        if wquTop.connected(node: wquBottom) {
            return .one
        } else if wquLeft.connected(node: wquRight) {
            return .two
        } else {
            return .empty
        }
    }
    @Published var board = [[Cell]]()
    @Published var turn = Player.one
    @Published var lastMove: (Int, Int)? = nil
    
    var wquTop = WeightedQuickUnionNode()
    var wquBottom = WeightedQuickUnionNode()
    var wquLeft = WeightedQuickUnionNode()
    var wquRight = WeightedQuickUnionNode()
    
    init(size: Int = 6) {
        self.size = size
        board = Array(repeating: Array(repeating: Cell(), count: size), count: size)
        newGame()
    }
    
    func newGame() {
        board = Array(repeating: Array(repeating: Cell(), count: size), count: size) // create 2D array to represent the board
        for r in 0..<size {
            for q in 0..<size {
                board[r][q] = Cell()
            }
        }
        resetWQUs()
    }
    
    func resetWQUs() {
        wquTop = WeightedQuickUnionNode()
        wquBottom = WeightedQuickUnionNode()
        wquLeft = WeightedQuickUnionNode()
        wquRight = WeightedQuickUnionNode()
    }
    
    func move(r: Int, q: Int) {
        let cell = board[r][q]
        if cell.state == .empty {
            cell.state = turn
            for neighbor in getNeighbors(r: r, q: q) {
                if neighbor.state == cell.state {
                    cell.wquNode.union(node: neighbor.wquNode)
                }
            }
            connectEdges(r: r, q: q)
            toggleTurn()
        }
    }
    
    func connectEdges(r: Int, q: Int) {
        let cell = board[r][q]
        if cell.state == .one {
            if r == 0 {
                cell.wquNode.union(node: wquTop)
            } else if r == size - 1 {
                cell.wquNode.union(node: wquBottom)
            }
        } else if cell.state == .two {
            if q == 0 {
                cell.wquNode.union(node: wquLeft)
            } else if q == size - 1 {
                cell.wquNode.union(node: wquRight)
            }
        }
    }
    
    func toggleTurn() {
        turn = turn == .one ? .two : .one
    }
    
    func undo() {
        if let (r, q) = lastMove {
            board[r][q].state = .empty
            toggleTurn()
        }
    }
    
//    func checkForWin() -> Player? {
//        if wquTop.connected(node: wquBottom) {
//            return .one
//        } else if wquLeft.connected(node: wquRight) {
//            return .two
//        } else {
//            return nil
//        }
//    }
    
    func getCell(r: Int, q: Int) -> Cell? {
        if r >= 0 && r < size && q >= 0 && q < size {
            return board[r][q]
        } else {
            return nil
        }
    }
    
    func getNeighbors(r: Int, q: Int) -> [Cell] {
        var neighbors = [Cell]()
        if let cell = getCell(r: r - 1, q: q + 0) { neighbors.append(cell) }
        if let cell = getCell(r: r - 1, q: q + 1) { neighbors.append(cell) }
        if let cell = getCell(r: r + 0, q: q - 1) { neighbors.append(cell) }
        if let cell = getCell(r: r + 0, q: q + 1) { neighbors.append(cell) }
        if let cell = getCell(r: r + 1, q: q - 1) { neighbors.append(cell) }
        if let cell = getCell(r: r + 1, q: q + 0) { neighbors.append(cell) }
        return neighbors
    }
}

extension HexGame {
    class Cell {
        var state = Player.empty
        let wquNode = WeightedQuickUnionNode()
    }
    
    enum Player {
        case one, two, empty
    }
}

