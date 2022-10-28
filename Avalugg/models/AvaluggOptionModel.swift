//
//  AvaluggOptionModel.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import Foundation

struct AvaluggOptionModel : Hashable {
    let optionName: String
    let optionHint: String
    let optionType: AndroidEventType
    let isOptionEnabled: Bool
}
