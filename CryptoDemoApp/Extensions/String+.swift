//
//  String+.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 27.11.2022.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}

