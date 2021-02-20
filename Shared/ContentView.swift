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
            HexGrid(rows: 3, columns: 3)
            
            HStack {
                Hexagon()
                    .strokeBorder(lineWidth: 10.0)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        print("tapped")
                    }
                    .background(Color.red)
                
                Hexagon()
//                    .strokeBorder(lineWidth: 10.0)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        print("tapped")
                    }
                    .background(Color.red)
            }
            
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 1) {
                Hexagon()
                    .strokeBorder(lineWidth: 2.0)
                    .foregroundColor(.black)
                    .onTapGesture {
                        print("tapped")
                    }
                    .background(Color.red)
                
                Hexagon()
                    .fill()
//                    .inset(by: 5)
                    .onTapGesture {
                        print("tapped")
                    }
                    .foregroundColor(.gray)
                    .opacity(0.8)
//                    .clipShape(Hexagon())
                    .overlay(Hexagon().strokeBorder(Color.black, lineWidth: 2))
                    
                    .background(Color.red)
            }
        }
        .frame(width: 200, height: 250)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

