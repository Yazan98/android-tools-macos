//
//  PanelOptionView.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import SwiftUI

struct PanelOptionView: View {
    
    // Views Listeners
    @State private var isOptionEnabled = true
    
    // View Information
    private var optionName: String = ""
    private var optionType: AndroidEventType! = AndroidEventType.overDrawUI
    private var viewModel: AndroidOptionsViewModel! = nil
    

    init(optionName: String, optionType: AndroidEventType, viewModel: AndroidOptionsViewModel) {
        self.optionName = optionName
        self.optionType = optionType
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(self.optionName)
            
            Spacer()
            
            Toggle("", isOn: $isOptionEnabled)
                .toggleStyle(SwitchToggleStyle(tint: .red))
                
        }.padding(10).frame(width: 290)
    }
    
}
