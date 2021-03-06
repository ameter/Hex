//
//  Hexagon.swift
//  Hex
//
//  Created by Chris on 2/20/21.
//

import SwiftUI

struct Hexagon: InsettableShape {
    var insetAmount: CGFloat = 0
    
    enum Orientation {
        case pointyTop
        case flatTop
    }
    
    let orientation: Orientation
    let points: [Int]
    
    init(orientation: Orientation = .flatTop, points: [Int] = Array(0...5)) {
        self.orientation = orientation
        self.points = points
    }
    
    func path(in rect: CGRect) -> Path {
        // We want to draw a hexagon
        let sides = 6
        let exteriorAngle = 360.0 / Double(sides) //* .pi / 180
        let interiorAngle = Double(sides - 2) * 180.0 / Double(sides)
        let rotation = orientation == .pointyTop ? 90.0 : interiorAngle // /2
        let width = rect.width - insetAmount * 2
        let height = rect.height - insetAmount * 2
        var size = 0.0
        if orientation == .pointyTop {
            let widthR = (Double(width) / 2.0) / sin(exteriorAngle * .pi / 180)
            let heightR = Double(height) / 2.0
            size = min(widthR, heightR)
        } else {
            let heightR = (Double(height) / 2.0) / sin(exteriorAngle * .pi / 180)
            let widthR = Double(width) / 2.0
            size = min(widthR, heightR)
        }
        
        // we're ready to start with our path now
        var path = Path()
        
        // loop over all our points
        var firstPoint = true
        for side in 0..<sides  {
            if points.contains(side) {
                let angle = (Double(side) * exteriorAngle - rotation) * .pi / 180
                let point = CGPoint(
                    x: rect.midX + CGFloat(cos(angle) * size),
                    y: rect.midY + CGFloat(sin(angle) * size)
                )
                // move to our first corner or draw a line to our next corner
                if firstPoint {
                    path.move(to: point)
                    firstPoint = false
                } else {
                    path.addLine(to: point)
                }
            }
        }
        if points.contains(6) {
            let angle = (Double(0) * exteriorAngle - rotation) * .pi / 180
            let point = CGPoint(
                x: rect.midX + CGFloat(cos(angle) * size),
                y: rect.midY + CGFloat(sin(angle) * size)
            )
            path.addLine(to: point)
        }
        
        if points.count == sides {
            path.closeSubpath()
        }
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var hexagon = self
        hexagon.insetAmount += amount
        return hexagon
    }
}
