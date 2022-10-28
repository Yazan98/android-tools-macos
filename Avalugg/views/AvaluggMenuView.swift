//
//  AvaluggMenuView.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import SwiftUI

struct AvaluggMenuView: View {
    
    private var viewModel: AndroidOptionsViewModel = AndroidOptionsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Android Device Developer Options").padding(10)
            
            ForEach(viewModel.getOptionsList(), id: \.self) { option in
                PanelOptionView(
                    optionName: option.optionName,
                    optionType: option.optionType,
                    viewModel: viewModel
                )
            }
            
            Spacer()
        }.padding(10)
    }
    
}

struct AvaluggMenuView_Previews: PreviewProvider {
    static var previews: some View {
        AvaluggMenuView()
    }
}
