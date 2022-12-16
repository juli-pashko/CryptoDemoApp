//
//  Double+.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 18.11.2022.
//

import Foundation

extension Double {
    
    
    /// Converts a Double into a Currency with 2  demical places
    ///```
    ///Convert 1345.66 to $1,345.66
    ///```
    private var currencyFormatter2: NumberFormatter {
        let formater = NumberFormatter()
        formater.usesGroupingSeparator = true
        formater.numberStyle = .currency
//        formater.locale = .current // <- default value
//        formater.currencyCode = "usd" // <- change currency
//        formater.currencySymbol = "$" // <- change currency symbol
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 2
        return formater
    }
    
    /// Converts a Double into a Currency as String with 2 demical places
    ///```
    ///Convert 1345.66 to "$1,345.66"
    ///```
    func asCurrencyWith2Demicals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    
    
    /// Converts a Double into a Currency with 2-6 demical places
    ///```
    ///Convert 1345.66 to $1,345.66
    ///Convert 13.4566 to $13.4566
    ///Covert 0.134566 to $0.134566
    ///```
    private var currencyFormatter6: NumberFormatter {
        let formater = NumberFormatter()
        formater.usesGroupingSeparator = true
        formater.numberStyle = .currency
//        formater.locale = .current // <- default value
//        formater.currencyCode = "usd" // <- change currency
//        formater.currencySymbol = "$" // <- change currency symbol
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 6
        return formater
    }
    
    /// Converts a Double into a Currency as String with 2-6 demical places
    ///```
    ///Convert 1345.66 to "$1,345.66"
    ///Convert 13.4566 to "$13.4566"
    ///Covert 0.134566 to "$0.134566"
    ///```
    func asCurrencyWith6Demicals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    
    /// Converts a Double into String representation
    ///```
    ///Convert 1.3458 to "1.34"
    ///```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into String representation with percent symbol
    ///```
    ///Convert 1.3458 to "1.34%"
    ///```
    
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }

}
