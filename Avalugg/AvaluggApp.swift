//
//  AvaluggApp.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import SwiftUI

@main
struct AvaluggApp: App {
    
    @NSApplicationDelegateAdaptor(RootAppDelegate.self) private var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
