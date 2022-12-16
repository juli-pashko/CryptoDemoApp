//
//  NavigationBarView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 06.12.2022.
//

import SwiftUI

struct CustomNavigationBarView: View {
 
    //MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String
    let subtitle: String?
    
    
    //MARK: Body
    var body: some View {
        HStack {
            if showBackButton {
                backButton
            }
            Spacer()
            titleSection
            Spacer()
            if showBackButton {
                backButton
                    .opacity(0)
            }
            
        }//: HStack
        .padding()
        .accentColor(Color.theme.accent) //nav batton color
        .foregroundColor(Color.theme.accent) //titles colors
        .font(.mainFont(ofSize: 20, weight: .bold))// button back
        .background(Color.theme.background)
    }

}


//MARK: - NavigationBarView_Previews
struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavigationBarView(showBackButton: true, title: "Title", subtitle: "Subtitle")
            Spacer()
        }//: VStack
    }
}


//MARK: - CustomNavigationBarView Extension
extension CustomNavigationBarView {
    
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image("arrowLeftIcon")
        }//: Left nav button
        
    }
    
    private var titleSection: some View {
        VStack {
            Text(title)
                .withCustomTitleModifire()
            if let subtitle = subtitle {
                Text(subtitle)
            }
        }
    }
    
    private var closeButton: some View {
        Button(action: {
           presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: Icon.xmark)
           .font(.headline)
        })
    }
    
}

