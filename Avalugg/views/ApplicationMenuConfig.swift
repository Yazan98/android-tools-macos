//
//  ApplicationMenuConfig.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 29/10/2022.
//

import Foundation
import SwiftUI

class ApplicationMenuConfiguration : NSObject {
    
    @objc func onAboutMenuItem(menu: NSMenuItem) {
        NSApp.orderFrontStandardAboutPanel()
    }
    
    @objc func onQuitApplication(menu: NSMenuItem) {
        NSApp.terminate(self)
    }
    
    @objc func onOpenApplicationRepositoryLink(sender: NSMenuItem) {
        let link = sender.representedObject as! String
        guard let url = URL(string: link) else { return }
        NSWorkspace.shared.open(url)
    }
    
    func getAboutMenuItem() -> NSMenuItem {
        return NSMenuItem(
            title: "About",
            action: #selector(onAboutMenuItem),
            keyEquivalent: ""
        )
    }
    
    func getRepositoryLinkMenuItem() -> NSMenuItem {
        return NSMenuItem(
            title: "Project Repository",
            action: #selector(onOpenApplicationRepositoryLink),
            keyEquivalent: ""
        )
    }
    
    func getRepositorySubmitIssueLinkMenuItem() -> NSMenuItem {
        return NSMenuItem(
            title: "Submit Issue",
            action: #selector(onOpenApplicationRepositoryLink),
            keyEquivalent: ""
        )
    }
    
    func getQuitApplicationMenuItem() -> NSMenuItem {
        return NSMenuItem(
            title: "Quit",
            action: #selector(onOpenApplicationRepositoryLink),
            keyEquivalent: ""
        )
    }
    
    
}
