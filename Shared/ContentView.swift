//
//  ContentView.swift
//  Shared
//
//  Created by Chris on 2/19/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Circle()
                .inset(by: 5)
            
            Hexagon(orientation: .pointyTop)
//                .inset
                .strokeBorder(lineWidth: 10.0)
                .foregroundColor(.blue)
                .onTapGesture {
                    print("tapped")
                }
                .frame(width: 400, height: 250)
                //.contentShape(Hexagon(orientation: .pointyTop))
                
                
                
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

