//
//  RootAppDelegate.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import Foundation
import SwiftUI

class RootAppDelegate : NSObject, NSApplicationDelegate, ObservableObject {
    
    static private(set) var instance: RootAppDelegate!
    lazy var statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let menu = AvaluggMenuView()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        RootAppDelegate.instance = self
        statusBarItem.button?.image = NSImage(named: NSImage.Name("menu_icon"))
        statusBarItem.button?.imagePosition = .imageLeading
        statusBarItem.menu = menu.createMenu()
    }
    
}
