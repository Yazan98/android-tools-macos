//
//  AndroidOptionsViewModel.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import Foundation

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
        let result = try? safeShell(self.getAndroidDebugBridgeConnectionPath() + " devices")
        return "Your Device Connected : " + result!
    }
    
    @discardableResult
    func safeShell(_ command: String) throws -> String {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")
        task.standardInput = nil

        try task.run()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!
        
        return output
    }
    
    func getAndroidDebugBridgeConnectionPath() -> String {
        return "~/Library/Android/sdk/platform-tools/adb"
    }
    
}
