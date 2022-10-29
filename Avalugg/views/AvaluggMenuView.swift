//
//  AvaluggMenuView.swift
//  Avalugg
//
//  Created by Yazan Tarifi on 28/10/2022.
//

import SwiftUI

struct AvaluggMenuView: View {
    
    // ViewModels
    @ObservedObject private var viewModel: AndroidOptionsViewModel = AndroidOptionsViewModel()
    @ObservedObject private var commandsViewModel: ApplicationCommandsViewModel = ApplicationCommandsViewModel()
    
    // Application Listeners
    @State var refresh: Bool = false
    @State var applicationPackageNameInput: String = ""
    
    // Application Information
    private let menu = NSMenu()
    private let applicationMenuConfiguration = ApplicationMenuConfiguration()

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            VStack(alignment: .leading) {
                Text("Android Device Developer Options")
                Text("Your Connected Device : " + viewModel.currentConnectedDevice).font(.system(size: 10))
            }.padding(10)
            
            ForEach(viewModel.getOptionsList(), id: \.self) { option in
                PanelOptionView(
                    optionName: option.optionName,
                    optionType: option.optionType,
                    viewModel: viewModel
                )
            }
            
            Text("")
            
            Text("Application Development")
                .padding(.top, 10)
                .padding(.horizontal, 10)
            
            TextField(
              "Application Package Name",
              text: $applicationPackageNameInput,
              onEditingChanged: { changed in
                  UserDefaults.standard.set(applicationPackageNameInput, forKey: "ApplicationWorkingPackageName")
              }
            ).padding(10)
            
            ForEach(commandsViewModel.getApplicationOptions(), id: \.self) { option in
                ApplicationOptionView(
                    viewModel: viewModel,
                    applicationViewModel: commandsViewModel,
                    optionName: option.optionName,
                    optionKey: option.optionKey
                )
            }
            
            Spacer()
            
            
            Text("Request Connected Device")
                .padding(10)
                .onTapGesture {
                    viewModel.validateConnectedDevice()
                }
        }
        .padding(10)
        .onAppear(perform: onMainViewAppear)
    }
    
    func onMainViewAppear() {
        refresh.toggle()
        applicationPackageNameInput = UserDefaults.standard.string(forKey: "ApplicationWorkingPackageName") ?? ""
        DispatchQueue.global(qos: .background).async {
            viewModel.validateConnectedDevice()
        }
    }
    
    func createMenu() -> NSMenu {
        let parentView = AvaluggMenuView()
        let topView = NSHostingController(rootView: parentView)
        topView.view.frame.size = CGSize(width: 300, height: 550)
                
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
