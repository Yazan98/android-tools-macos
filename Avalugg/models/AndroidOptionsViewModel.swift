//
//  AndroidOptionsViewModel.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import Foundation
import Cocoa

class AndroidOptionsViewModel {
    
    func onSwitchTriggered(optionType: AndroidEventType, state: Bool) {
        
    }
    
    func getOptionsList() -> [AvaluggOptionModel] {
        return [
            AvaluggOptionModel(
                optionName: "Show Layout Bounds",
                optionHint: "Available on Almost Devices",
                optionType: AndroidEventType.showLayoutBounds,
                isOptionEnabled: self.isOptionEnabled(androidEvent: AndroidEventType.showLayoutBounds)
            ),
            AvaluggOptionModel(
                optionName: "Device Don't Keep Activites",
                optionHint: "Available on Almost Devices",
                optionType: AndroidEventType.dontKeepActivites,
                isOptionEnabled: self.isOptionEnabled(androidEvent: AndroidEventType.dontKeepActivites)
            ),
            AvaluggOptionModel(
                optionName: "Show Taps",
                optionHint: "Available on Almost Devices",
                optionType: AndroidEventType.showTaps,
                isOptionEnabled: self.isOptionEnabled(androidEvent: AndroidEventType.showTaps)
            ),
            AvaluggOptionModel(
                optionName: "Show Layout Bounds",
                optionHint: "Available on Almost Devices",
                optionType: AndroidEventType.showLayoutBounds,
                isOptionEnabled: self.isOptionEnabled(androidEvent: AndroidEventType.showLayoutBounds)
            )
        ]
    }
    
    func isOptionEnabled(androidEvent: AndroidEventType) -> Bool {
        return true
    }
    
    func getAdbConnectedDevice() -> String {
        return "Your Device Connected : " + shell("adb devices")
    }
    
    func shell(_ command: String) -> String {
        let task = Process()
                task.launchPath = "/bin/zsh"
                let mac:[String] = ["-c", command]
                task.arguments = mac
                // ifconfig en0 | awk '/ether/{print $2}'
                let pipe = Pipe()
                task.standardOutput = pipe
                task.launch()
                task.waitUntilExit()
                let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data,  encoding: .utf8)!
    }
    
}
