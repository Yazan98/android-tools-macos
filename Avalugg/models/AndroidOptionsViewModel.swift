//
//  AndroidOptionsViewModel.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import Foundation

class AndroidOptionsViewModel {
    
    func execute(optionType: AndroidEventType) {
        
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
                optionName: "Show Layout Bounds",
                optionHint: "Available on Almost Devices",
                optionType: AndroidEventType.showLayoutBounds,
                isOptionEnabled: self.isOptionEnabled(androidEvent: AndroidEventType.showLayoutBounds)
            ),
            AvaluggOptionModel(
                optionName: "Show Layout Bounds",
                optionHint: "Available on Almost Devices",
                optionType: AndroidEventType.showLayoutBounds,
                isOptionEnabled: self.isOptionEnabled(androidEvent: AndroidEventType.showLayoutBounds)
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
    
}
