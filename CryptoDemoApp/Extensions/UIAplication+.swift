//
//  UIAplication+.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 19.11.2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

}
