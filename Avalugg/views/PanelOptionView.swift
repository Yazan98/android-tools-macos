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
    }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(self.optionName)
            
            Spacer()
            
            Toggle("", isOn: $isOptionEnabled)
                .toggleStyle(SwitchToggleStyle(tint: .red))
                .onChange(of: isOptionEnabled) { value in
                    viewModel.onSwitchTriggered(optionType: optionType, state: value)
                }
        }
        .padding(10)
        .frame(width: 290)
        .onAppear(perform: fetch)
        .onDisappear {
            self.isOptionEnabled = false
        }
    }
    
    private func fetch() {
        DispatchQueue.global(qos: .background).async {
            let isOptionEnabledResult = viewModel.isOptionEnabled(androidEvent: optionType)
            DispatchQueue.main.async {
                self.isOptionEnabled = isOptionEnabledResult
            }
        }
    }
    
}
