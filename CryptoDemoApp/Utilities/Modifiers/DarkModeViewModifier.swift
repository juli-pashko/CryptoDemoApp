//
//  DarkModeViewModifier.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 02.12.2022.
//

import SwiftUI

public struct DarkModeViewModifier: ViewModifier {
   
    @AppStorage(Constants.Key.appearance) var isDarkMode: Bool = true
   
    public func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
            .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
