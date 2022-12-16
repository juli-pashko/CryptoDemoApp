//
//  SettingsRowView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 02.12.2022.
//

import SwiftUI

struct SettingsRowView: View {
    
    //MARK: - Properties
    var name: String
    var content: String? = nil
    var linkLabel: String? = nil
    var linkDestination: String? = nil


    // MARK: - Body
    var body: some View {
        VStack {
            Divider().padding(.vertical, 4)
            HStack {
                settingsName
                Spacer()
                
                if (content != nil) {
                    settingsContent
                }
                
                if let _ = linkLabel,
                   let _ = linkDestination {
                    settingsLink
                } else {
                    EmptyView()
                }
            }//: HStack
        }//: VStack
    }
}


//MARK: - SettingsRowView_Previews
struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsRowView(name: Constants.SettingsInput.dev, content: Constants.SettingsInput.devContent)
                .previewLayout(.fixed(width: 375, height: 60))
                .padding()
            SettingsRowView(name: Constants.SettingsInput.sourceCode, linkLabel: Constants.SettingsInput.sourceCodeContent, linkDestination: Constants.URL.github)
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 375, height: 60))
                .padding()
        }
    }
}


//MARK: - SettingsRowView
extension SettingsRowView {
    
    //MARK: - Views
    private var settingsName: some View {
        Text(name).foregroundColor(Color.theme.secondaryText)
            .font(.mainFont(ofSize: 16, weight: .regular))
    }
    
    private var settingsContent: some View {
        Text(content!)
            .font(.mainFont(ofSize: 16, weight: .medium))
    }
    
    private var settingsLink: some View {
        HStack {
            Link(linkLabel!, destination: URL(string: linkDestination!)!)
                .font(.mainFont(ofSize: 16, weight: .medium))
            Image(systemName: Icon.arrowUpRightSquare)
        }
        .foregroundColor(Color.theme.green)
    }
}
