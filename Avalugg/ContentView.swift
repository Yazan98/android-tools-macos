//
//  ContentView.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import SwiftUI

/**
 A Not Used Window
 This Exists here because i need to test the window design before i add it to menu item
 */
struct ContentView: View {
    var body: some View {
        VStack {
            AvaluggMenuView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
