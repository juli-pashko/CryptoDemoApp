//
//  ScrollViewOffsetPreferenceKey.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 07.12.2022.
//

import Foundation
import SwiftUI


struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0.0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


extension View {
    
    func onScrollViewChange(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        background(
            GeometryReader { geo in
                Text("")
                    .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
            }
        )
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                action(value)
            }
    }
    
}
