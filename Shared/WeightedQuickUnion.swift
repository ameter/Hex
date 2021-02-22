//
//  WeightedQuickUnion.swift
//  Hex
//
//  Created by Chris on 2/21/21.
//

import Foundation

/*
 Implementation of Weighted Quick Union algorithm.
 
 Checks for connections between nodes on a 2D grid.
 
 Note: I could have passed the hashes around as references to the nodes, but I chose to the direct memory addresses instead.  The only reason we store them in a hash table is to facilitate referencing them from the corresponding coordinates in the 2D grid.
 
 https://karen-pedraza-1013.medium.com/weighted-quick-union-algorithm-explained-ab6d8b47fe1b
 */


class WeightedQuickUnion {
    class Node {
        var parent: Node? = nil
        var weight = 1
        
        var root: Node {
            var root = self
            while let nextUp = root.parent {
                root = nextUp
            }
            return root
        }
    }
    
    var nodes = [Int : Node]()

    func addNode(r: Int, q: Int) {
        nodes[hash(r: r, q: q)] = Node()
    }
    
    func getNode(r: Int, q: Int) -> Node? {
        return nodes[hash(r: r, q: q)]
    }
    
    func hash(r: Int, q: Int) -> Int {
        var hasher = Hasher()
        hasher.combine(r)
        hasher.combine(q)
        let hash = hasher.finalize()
        return hash
    }
    
    func union(nodeA: Node, nodeB: Node) {
        if nodeA.root.weight > nodeB.root.weight {
            nodeB.root.parent = nodeA.root
            nodeA.root.weight += nodeB.weight
        } else {
            nodeA.root.parent = nodeB.root
            nodeB.root.weight += nodeA.weight
        }
    }
    
    func connected(nodeA: Node, nodeB: Node) -> Bool {
        nodeA.root === nodeB.root
    }
}
