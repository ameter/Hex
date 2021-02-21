//
//  ContentView.swift
//  Shared
//
//  Created by Chris on 2/19/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var hvm = HexVM(size: 7)
    
    var body: some View {
        ZStack {
            VStack {
                Text(hvm.turn == .one ? "Blue's Turn" : "Red's Turn")
                
                Spacer()
            }
            
            HexGrid(hexVM: hvm)
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

