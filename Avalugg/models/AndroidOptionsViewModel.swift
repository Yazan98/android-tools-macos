//
//  AndroidOptionsViewModel.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import Foundation

class AndroidOptionsViewModel {
    
    private var currentConnectedDevice: String = ""
    private let COMMAND_GET_DEVICE_INFORMATION = "shell settings list system"
    
    func onSwitchTriggered(optionType: AndroidEventType, state: Bool) {
        switch (optionType) {
        case .showTaps:
            if state {
                self.onTryCommandLine(command: "shell settings put system show_touches 1")
            } else {
                self.onTryCommandLine(command: "shell settings put system show_touches 0")
            }
            break
            
        case .togglePointerLocation:
            if state {
                self.onTryCommandLine(command: "shell settings put system pointer_location 1")
            } else {
                self.onTryCommandLine(command: "shell settings put system pointer_location 0")
            }
            break
            
        default:
            break
        }
    }
    
    func getOptionsList() -> [AvaluggOptionModel] {
        return [
            AvaluggOptionModel(
                optionName: "Show Layout Bounds",
                optionHint: "Available on Almost Devices",
                optionType: AndroidEventType.showLayoutBounds,
                isOptionEnabled: self.isOptionEnabled(androidEvent: AndroidEventType.showLayoutBounds)
            ),AvaluggOptionModel(
                optionName: "Pointer Location",
                optionHint: "Available on Almost Devices",
                optionType: AndroidEventType.togglePointerLocation,
                isOptionEnabled: self.isOptionEnabled(androidEvent: AndroidEventType.togglePointerLocation)
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
        var isOptionEnabledByCommandType: Bool = false
        switch (androidEvent) {
        case .showTaps:
            isOptionEnabledByCommandType = self.isOptionSelectedByKey(key: "show_touches")
            break
        case .togglePointerLocation:
            isOptionEnabledByCommandType = self.isOptionSelectedByKey(key: "pointer_location")
        default:
            isOptionEnabledByCommandType = false
            break
        }
        return isOptionEnabledByCommandType
    }
    
    private func onTryCommandLine(command: String) {
        do {
            try self.safeShell(self.getAndroidDebugBridgeConnectionPath() + " " + command)
        } catch {
            print("Error :: \(error)")
        }
    }
    
    private func isOptionSelectedByKey(key: String) -> Bool {
        let properityInfo = self.getProperityValueByInformationKey(key: key)
        let rowFragments = properityInfo.split(separator: "=")
        if rowFragments[1].contains("1") {
            return true
        } else {
            return false
        }
    }
    
    private func getProperityValueByInformationKey(key: String) -> String {
        let deviceInformation = self.getDeviceInformationByAdb()
        var targetRow: String = ""
        deviceInformation.forEach { row in
            if row.contains(key) {
                targetRow = row
            }
        }
        return targetRow
    }
    
    private func getDeviceInformationByAdb() -> [String] {
        var commandResults = try? safeShell(self.getAndroidDebugBridgeConnectionPath() + " " + COMMAND_GET_DEVICE_INFORMATION)
        return ("" + commandResults!).split{$0 == "\n"}.map(String.init)
    }
    
    
    func getAdbConnectedDevice() -> String {
        return "Your Device Connected : " + self.getConnectedDeviceName()
    }
    
    private func getConnectedDeviceName() -> String {
        if !currentConnectedDevice.isEmpty {
            return currentConnectedDevice
        }
        
        let result = try? safeShell(self.getAndroidDebugBridgeConnectionPath() + " devices")
        let devices = result!.split{$0 == "\n"}.map(String.init)
        let firstDevice = devices[1].split{$0 == " "}.map(String.init)
        let resultFiltered = firstDevice[0].replacingOccurrences(of: "device", with: "").trimmingCharacters(in: .whitespaces)
        currentConnectedDevice = resultFiltered
        return resultFiltered
    }
    
    @discardableResult
    private func safeShell(_ command: String) throws -> String {
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
    
    private func getAndroidDebugBridgeConnectionPath() -> String {
        return "~/Library/Android/sdk/platform-tools/adb"
    }
    
}
