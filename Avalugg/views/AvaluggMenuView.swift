//
//  AvaluggMenuView.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import SwiftUI

struct AvaluggMenuView: View {
    
    private let menu = NSMenu()
    private let applicationMenuConfiguration = ApplicationMenuConfiguration()
    private var viewModel: AndroidOptionsViewModel = AndroidOptionsViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            VStack(alignment: .leading) {
                Text("Android Device Developer Options")
                Text(viewModel.getAdbConnectedDevice()).font(.system(size: 10))
            }.padding(10)
            
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
    
    
    func createMenu() -> NSMenu {
        let parentView = AvaluggMenuView()
        let topView = NSHostingController(rootView: parentView)
        topView.view.frame.size = CGSize(width: 300, height: 300)
        
        let customMenu = NSMenuItem()
        customMenu.view = topView.view
        
        menu.addItem(customMenu)
        menu.addItem(NSMenuItem.separator())
        
        let aboutMenuItem = applicationMenuConfiguration.getAboutMenuItem()
        aboutMenuItem.target = applicationMenuConfiguration
        
        let repositoryLink = applicationMenuConfiguration.getRepositoryLinkMenuItem()
        repositoryLink.target = applicationMenuConfiguration
        repositoryLink.representedObject = "https://github.com/Yazan98/android-tools-macos"
        
        let repositorySubmitIssueLink = applicationMenuConfiguration.getRepositorySubmitIssueLinkMenuItem()
        repositorySubmitIssueLink.target = applicationMenuConfiguration
        repositorySubmitIssueLink.representedObject = "https://github.com/Yazan98/android-tools-macos/issues"

        let quitButtonItem = applicationMenuConfiguration.getQuitApplicationMenuItem()
        quitButtonItem.target = applicationMenuConfiguration
        
        menu.addItem(repositoryLink)
        menu.addItem(repositorySubmitIssueLink)
        menu.addItem(aboutMenuItem)
        menu.addItem(quitButtonItem)
        
        return menu
    }
    
}

struct AvaluggMenuView_Previews: PreviewProvider {
    static var previews: some View {
        AvaluggMenuView()
    }
}
