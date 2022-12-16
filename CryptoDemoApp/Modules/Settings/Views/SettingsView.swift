//
//  SettingsView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 27.11.2022.
//

import SwiftUI

struct SettingsView: View {
    
    //MARK: - Properties
    @AppStorage(Constants.Key.appearance) var isDarkMode: Bool = true
    @Environment(\.presentationMode) var presentationMode
    @State private var scrollViewOffset: CGFloat = 0.0
  
    
    //MARK: - Body
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    headerView
                        .opacity(Double(scrollViewOffset) / 103) 
                    aboutAppSection
                    customizationSection
                    developerSection
                } //: VStack
                .padding()
            } //: ScrollView
            .overlay(
                navBarLayer
                    .opacity(scrollViewOffset < 40 ? 1.0 : 0.0)
                , alignment: .top
            )
        .modifier(DarkModeViewModifier())
    }
}


//MARK: - SettingsView_Previews
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


//MARK: - SettingsView Extension
extension SettingsView {
    
    //MARK: Views
    private var headerView: some View {
        HStack {
            Text(Constants.Settings.title.uppercased())
                .font(.mainFont(ofSize: 24, weight: .bold))
                .onScrollViewChange { offset in
                    self.scrollViewOffset = offset
                }
            Spacer()
            HStack(spacing: 8) {
                closeButton
            }
        }//: HStack
        .padding(EdgeInsets(top: 30, leading: 16, bottom: 8, trailing: 16))
    }
    
    private var navBarLayer: some View {
        Text(Constants.Settings.title.uppercased())
            .font(.mainFont(ofSize: 16, weight: .bold))
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.theme.headerSheet)
    }
    
    
    //MARK: - Sections
    private var aboutAppSection: some View {
        GroupBox(
            label:
                Text(Constants.Settings.aboutApp)
                .withCustomTitleModifire(alignment: .leading)
        ) {
            Divider().padding(.vertical, 4)
            
            HStack(alignment: .center, spacing: 10) {
                Image(isDarkMode ? "settingsLogoDark" : "settingsLogoLight")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                
                Text(Constants.Settings.aboutAppDescr)
                    .font(.mainFont(ofSize: 14, weight: .regular))
                    .foregroundColor(Color.theme.accent)
            }
        }
    }
    
    private var customizationSection: some View {
        GroupBox(
            label:
                Text(Constants.Settings.customization)
                .withCustomTitleModifire(alignment: .leading)
        ) {
            Divider().padding(.vertical, 4)
            
            Text(Constants.Settings.customizationDescr)
                .padding(.vertical, 8)
                .frame(minHeight: 60)
                .layoutPriority(1)
                .font(.mainFont(ofSize: 14, weight: .regular))
                .foregroundColor(Color.theme.accent)
                .multilineTextAlignment(.leading)
            
            Toggle(isOn: $isDarkMode) {
                if isDarkMode {
                    Text(Constants.Settings.darkAppearance)
                        .font(.mainFont(ofSize: 16, weight: .bold))
                        .foregroundColor(Color.theme.green)
                } else {
                    Text(Constants.Settings.lightAppearance)
                        .font(.mainFont(ofSize: 16, weight: .bold))
                        .foregroundColor(Color.theme.secondaryText)
                }
            }
            .padding()
            .tint(Color.theme.green)
            .background(
                Color(UIColor.tertiarySystemBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            )
        }
    }
    
    private var developerSection: some View {
        GroupBox(
            label:
                Text(Constants.Settings.app)
                .withCustomTitleModifire(alignment: .leading)
        ) {
            SettingsRowView(name: Constants.SettingsInput.dev, content: Constants.SettingsInput.devContent)
            SettingsRowView(name: Constants.SettingsInput.compatibility, content:  Constants.SettingsInput.compatibilityContent)
            SettingsRowView(name: Constants.SettingsInput.swiftUI, content: Constants.SettingsInput.swiftUIContent)
            SettingsRowView(name: Constants.SettingsInput.sourceCode, linkLabel: Constants.SettingsInput.sourceCodeContent, linkDestination: Constants.URL.github)
            SettingsRowView(name: Constants.SettingsInput.api, linkLabel: Constants.SettingsInput.apiContent, linkDestination: Constants.URL.coingecko)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
        }
    }
    
    
    //MARK: - Controls
    private var closeButton: some View {
        Button(action: {
           presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: Icon.xmark)
           .font(.headline)
        })
    }

}
