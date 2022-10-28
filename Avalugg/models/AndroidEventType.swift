//
//  AndroidEventType.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import Foundation

enum AndroidEventType : String {
    case overDrawUI = "OverDrawUI",
         dontKeepActivites = "DontKeepActivities",
         backgroundProcessLimit = "BackgroundProcessLimit",
         gpuWatch = "GpuWatch",
         showViewUpdates = "ShowViewUpdates",
         showLayoutBounds = "ShowLayoutBounds",
         showTaps = "showTaps",
         togglePointerLocation = "TogglePointerLocation"
}
