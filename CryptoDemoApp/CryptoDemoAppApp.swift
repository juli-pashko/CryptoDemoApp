//
//  CryptoDemoAppApp.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 17.11.2022.
//

import SwiftUI

@main
struct CryptoDemoAppApp: App {
    
    //MARK: - Properties
    @StateObject private var viewModel = HomeViewModel()
    @State private var isShowLaunchView: Bool = true
    
    
    //MARK: - Initialization
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    
    //MARK: - Body
    var body: some Scene {
        WindowGroup {
            ZStack {
            NavigationView {
               HomeView()
                    .navigationBarHidden(true)
            }//: NavigationView
            .environmentObject(viewModel)
            .modifier(DarkModeViewModifier())
                ZStack {
                    if isShowLaunchView {
                        LaunchView(isShowLaunchView: $isShowLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }//: ZStack
                .zIndex(2.0)//above the NavigationView
            }//:ZStack
        }//: WindowGroup
        
    }
   
}
