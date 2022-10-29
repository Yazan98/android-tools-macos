//
//  ApplicationOptionView.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 29/10/2022.
//

import SwiftUI

struct ApplicationOptionView: View {
    
    private var viewModel: AndroidOptionsViewModel!
    private var applicationViewModel: ApplicationCommandsViewModel!
    private var optionName: String = ""
    private var optionKey: String = ""
    
    @State private var hover: Bool = false
    
    init(viewModel: AndroidOptionsViewModel!, applicationViewModel: ApplicationCommandsViewModel!, optionName: String, optionKey: String) {
        self.viewModel = viewModel
        self.applicationViewModel = applicationViewModel
        self.optionName = optionName
        self.optionKey = optionKey
    }
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(self.optionName)
                .foregroundColor(.gray)
                .onTapGesture {
                    applicationViewModel.onExecuteEvent(
                        adbPath: viewModel.getAndroidDebugBridgeConnectionPath(),
                        optionKey: self.optionKey,
                        connectedDevice: viewModel.getConnectedDeviceName()
                    )
                }.onHover { isHovered in
                    self.hover = isHovered
                    DispatchQueue.main.async {
                        if (self.hover) {
                            NSCursor.pointingHand.push()
                        } else {
                            NSCursor.pop()
                        }
                    }
                }
            
            Spacer()
        }
        .padding(.top, 3)
        .padding(.horizontal, 10)
        .frame(width: 290)
    }
    
}
