//
//  HapticManager.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 24.11.2022.
//

import Foundation
import SwiftUI


class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}

