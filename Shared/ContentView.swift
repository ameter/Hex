//
//  ContentView.swift
//  Shared
//
//  Created by Chris on 2/19/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HexGrid(hexVM: HexVM(size: 7))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

