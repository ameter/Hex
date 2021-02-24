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


class WeightedQuickUnionNode {
    var parent: WeightedQuickUnionNode? = nil
    var weight = 1
    
    var root: WeightedQuickUnionNode {
        var root = self
        while let nextUp = root.parent {
            root = nextUp
        }
        return root
    }
    
    func union(node: WeightedQuickUnionNode) {
        if node.root !== self.root { // only union them if they aren't already unioned!  This was a tricky bug to find.
            if node.root.weight > self.root.weight {
                self.root.parent = node.root
                node.root.weight += self.root.weight
            } else {
                node.root.parent = self.root
                self.root.weight += node.root.weight
            }
        }
    }
    
    func connected(node: WeightedQuickUnionNode) -> Bool {
        self.root === node.root
    }
}
