//
//  ContentView.swift
//  Shared
//
//  Created by Chris on 2/19/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var hvm = HexVM()
//    @ObservedObject var game: HexGame
    
//    init() {
//        let hvm = HexVM()
//        game = hvm.game
//        self.hvm = hvm
//    }
    
    var body: some View {
        ZStack {
            VStack {
                Text(hvm.turn)
                
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

