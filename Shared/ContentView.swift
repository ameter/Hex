//
//  ContentView.swift
//  Shared
//
//  Created by Chris on 2/19/21.
//

import SwiftUI

struct Hexagon: Shape {
    enum Orientation: Double {
        case pointyTop
        case flatTop
    }
    
    let orientation: Orientation
    
    func path(in rect: CGRect) -> Path {
        // We want to draw a hexagon
        let sides = 6
        let exteriorAngle = 360.0 / Double(sides) //* .pi / 180
        let interiorAngle = Double(sides - 2) * 180.0 / Double(sides)
        let rotation = orientation == .pointyTop ? 90.0 : interiorAngle / 2.0
        
        var size = 0.0
        if orientation == .pointyTop {
            let widthR = (Double(rect.width) / 2.0) / sin(exteriorAngle * .pi / 180)
            let heightR = Double(rect.height) / 2.0
            size = min(widthR, heightR)
        } else {
            let heightR = (Double(rect.height) / 2.0) / sin(exteriorAngle * .pi / 180)
            let widthR = Double(rect.width) / 2.0
            size = min(widthR, heightR)
        }
        
        // we're ready to start with our path now
        var path = Path()
        
        // loop over all our points
        for side in 0...sides  {
            let angle = (Double(side) * exteriorAngle - rotation) * .pi / 180
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
            Hexagon(orientation: .pointyTop)
                .frame(width: 400, height: 250)
                .background(Color.red)
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

