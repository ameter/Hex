//
//  ContentView.swift
//  Shared
//
//  Created by Chris on 2/19/21.
//

import SwiftUI

struct Star: Shape {
    // store how many corners the star has, and how smooth/pointed it is
    let corners: Int
    let smoothness: CGFloat
    
    func path(in rect: CGRect) -> Path {
        // ensure we have at least two corners, otherwise send back an empty path
        guard corners >= 2 else { return Path() }
        
        // draw from the center of our rectangle
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        // start from directly upwards (as opposed to down or to the right)
        var currentAngle = -CGFloat.pi / 2
        
        // calculate how much we need to move with each star corner
        let angleAdjustment = .pi * 2 / CGFloat(corners * 2)
        
        // figure out how much we need to move X/Y for the inner points of the star
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness
        
        // we're ready to start with our path now
        var path = Path()
        
        // move to our initial position
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)))
        
        // track the lowest point we draw to, so we can center later
        var bottomEdge: CGFloat = 0
        
        // loop over all our points/inner points
        for corner in 0..<corners * 2  {
            // figure out the location of this point
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: CGFloat
            
            // if we're a multiple of 2 we are drawing the outer edge of the star
            if corner.isMultiple(of: 2) {
                // store this Y position
                bottom = center.y * sinAngle
                
                // …and add a line to there
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                // we're not a multiple of 2, which means we're drawing an inner point
                
                // store this Y position
                bottom = innerY * sinAngle
                
                // …and add a line to there
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }
            
            // if this new bottom point is our lowest, stash it away for later
            if bottom > bottomEdge {
                bottomEdge = bottom
            }
            
            // move on to the next corner
            currentAngle += angleAdjustment
        }
        
        // figure out how much unused space we have at the bottom of our drawing rectangle
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2
        
        // create and apply a transform that moves our path down by that amount, centering the shape vertically
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace)
        return path.applying(transform)
    }
}

struct Hexagon: Shape {
    enum Orientation: Double {
        case pointyTop = 90.0
        case flatTop = 0.0
    }
    
    let orientation: Orientation
    
    func path(in rect: CGRect) -> Path {
        // We want to draw a hexagon
        let sides = 6
        let centerAngle = 360.0 / Double(sides) //* .pi / 180
        let interiorAngleHalf = Double(sides - 2) * 180.0 / Double(sides) / 2.0
//        let size = Double(min(rect.width, rect.height)) / 2.0
//        let size = size1
        let size = (Double(rect.width) / 2.0) / sin(centerAngle * .pi / 180)
        //let size = tan(internalAngle * .pi / 180) * size1 / 1.5
//        let size = size1 * 1.155
        //let size =  (size1 * sin(internalAngle * .pi / 180))
//        let size = size1 * sqrt(3)
        
        // we're ready to start with our path now
        var path = Path()
        
        // loop over all our points
        for side in 0...sides  {
//            let angle = (Double(side) * (centerAngle) - interiorAngleHalf) * .pi / 180
            let angle = (Double(side) * (centerAngle) - 90) * .pi / 180
            let point = CGPoint(
                x: rect.midX + CGFloat(cos(angle) * size),
                y: rect.midY + CGFloat(sin(angle) * size)
            )
            // move to our first corner or draw a line to our next corner
            side == 0 ? path.move(to: point) : path.addLine(to: point)
        }
        path.closeSubpath()
        
        return path
    }
}


struct ContentView: View {
    var body: some View {
        VStack {
//            Star(corners: 8, smoothness: 0.45)
//                .padding()
//                .scaledToFit()
//                .background(Color.red)
            Hexagon(orientation: .pointyTop)
                .background(Color.red)
                .frame(width: 250, height: 250, alignment: .leading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

