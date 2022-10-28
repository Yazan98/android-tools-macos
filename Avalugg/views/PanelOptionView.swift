//
//  PanelOptionView.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import SwiftUI

struct PanelOptionView: View {
    
    // Views Listeners
    @State private var isOptionEnabled = false
    
    // View Information
    private var optionName: String = ""
    private var optionType: AndroidEventType! = AndroidEventType.overDrawUI
    private var viewModel: AndroidOptionsViewModel! = nil
    

    init(optionName: String, optionType: AndroidEventType, viewModel: AndroidOptionsViewModel) {
        self.optionName = optionName
        self.optionType = optionType
        self.viewModel = viewModel
        self.isOptionEnabled = viewModel.isOptionEnabled(androidEvent: optionType)
        if viewModel.isOptionEnabled(androidEvent: optionType) {
            print("III :: \(self.optionName) : True")
        } else {
            print("III :: \(self.optionName) : Flase")
        }
    }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(self.optionName)
            
            Spacer()
            
            Toggle("", isOn: $isOptionEnabled)
                .toggleStyle(SwitchToggleStyle(tint: .red))
                .onChange(of: isOptionEnabled) { value in
                    viewModel.onSwitchTriggered(optionType: optionType, state: value)
                }.onAppear(perform: fetch)
                
        }.padding(10).frame(width: 290)
    }
    
    private func fetch() {
        self.isOptionEnabled = viewModel.isOptionEnabled(androidEvent: optionType)
    }
    
}
