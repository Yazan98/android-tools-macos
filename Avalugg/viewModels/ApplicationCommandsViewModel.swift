//
//  ApplicationCommandsViewModel.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 29/10/2022.
//

import Foundation

class ApplicationCommandsViewModel : ObservableObject {
    
    private let CLEAR_DATA_COMMAND = "clear"
    private let RESTART_COMMAND = "restart"
    private let UNINSTALL_COMMAND = "uninstall"
    private let CLEAR_DATA_AND_RESTART_COMMAND = "clearAndRestart"
    
    func getApplicationOptions() -> [ApplicationOptionModel] {
        return [
            ApplicationOptionModel(
                optionName: "Clear App Data",
                optionKey: CLEAR_DATA_COMMAND
            ),
            ApplicationOptionModel(
                optionName: "Force Stop Application",
                optionKey: RESTART_COMMAND
            ),
            ApplicationOptionModel(
                optionName: "Uninstall Application",
                optionKey: UNINSTALL_COMMAND
            ),
            ApplicationOptionModel(
                optionName: "Clear Application Data and Restart",
                optionKey: CLEAR_DATA_AND_RESTART_COMMAND
            )
        ]
    }
    
    func onExecuteEvent(adbPath: String, optionKey: String, connectedDevice: String) {
        let applicationPackageName = UserDefaults.standard.string(forKey: "ApplicationWorkingPackageName") ?? ""
        
        switch (optionKey) {
        case CLEAR_DATA_COMMAND:
            onTryCommandLine(command: "shell pm clear \(applicationPackageName)", adbPath: adbPath)
            break
            
        case RESTART_COMMAND:
            onTryCommandLine(command: "shell am force-stop \(applicationPackageName)", adbPath: adbPath)
            break
            
        case UNINSTALL_COMMAND:
            onTryCommandLine(command: "uninstall \(applicationPackageName)", adbPath: adbPath)
            break
            
        case CLEAR_DATA_AND_RESTART_COMMAND:
            onTryCommandLine(command: "shell pm clear \(applicationPackageName)", adbPath: adbPath)
            onTryCommandLine(command: "shell am force-stop \(applicationPackageName)", adbPath: adbPath)
            break
        default:
            break
        }
    }
    
    private func onTryCommandLine(command: String, adbPath: String) {
        do {
            try self.safeShell(adbPath + " " + command)
        } catch {
            print("Error :: \(error)")
        }
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
    
}
