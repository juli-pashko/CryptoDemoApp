//
//  TitleViewMidifier.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 02.12.2022.
//

import SwiftUI


struct TitleViewMidifier: ViewModifier {
    
    let ofSize: CGFloat
    let alignment: Alignment
    
    func body(content: Content) -> some View {
        content
            .font(.mainFont(ofSize: ofSize, weight: .bold))
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: alignment)
    }
}


extension View {
   
    func withCustomTitleModifire(ofSize: CGFloat = 20, alignment: Alignment = .center) -> some View {
        modifier(TitleViewMidifier(ofSize: ofSize, alignment: alignment))
    }

}
