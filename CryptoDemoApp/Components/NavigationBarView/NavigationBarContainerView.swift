//
//  NavigationBarContainerView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 06.12.2022.
//

import SwiftUI


struct NavigationBarContainerView<Content: View>: View {
    
    //MARK: - Properties
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var subtitle: String? = nil
    
    
    //MARK: - Initialization
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    
    //MARK: - Body
    var body: some View {
        VStack {
            CustomNavigationBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)
            Spacer()
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }//: VStack
        .onPreferenceChange(NavigationBarTitlePreferenceKey.self) { value in
            self.title = value
        }
        .onPreferenceChange(NavigationBarSubtitlePreferenceKey.self) { value in
            self.subtitle = value
        }
        .onPreferenceChange(NavigationBarBackButtonHiddenPreferenceKey.self) { value in
            self.showBackButton = !value
        }
    }

}


//MARK: - NavigationBarContainerView_Previews
struct NavigationBarContainerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarContainerView {
            ZStack {
                Color.yellow.opacity(0.3)
                    .ignoresSafeArea()
                Text("Some content here")
                    .customNavigationTitle("Title")
                    .customNavigationSubtitle("Subtitle")
            }//: ZStack
        }
    }
}
