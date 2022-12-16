//
//  Font+.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 29.11.2022.
//

import SwiftUI


extension Font {
    /// Main font family of the app is `Montserrat` now.
    static func mainFont(ofSize fontSize: CGFloat, weight: Font.Weight) -> Font {
        switch weight {
        case .light: return self.custom("Montserrat-Light", size: fontSize)
        case .medium: return self.custom("Montserrat-Medium", size: fontSize)
        case .semibold: return self.custom("Montserrat-SemiBold", size: fontSize)
        case .bold: return self.custom("Montserrat-Bold", size: fontSize)
        default: return self.custom("Montserrat-Regular", size: fontSize)
        }
    }
}

