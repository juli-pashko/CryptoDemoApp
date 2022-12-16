//
//  Constants.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 01.12.2022.
//

import SwiftUI

struct Constants {
   
    struct URL {
        static let coingecko = "https://www.coingecko.com"
        static let github = "https://github.com/juli-pashko/CryptoDemoApp"
    }
    
    struct Key {
        static let appearance = "isDarkMode"
    }
}


//MARK: - Home Screen
extension Constants {
    
    struct Home {
        static let portfolio = "Portfolio"
        static let livePrices = "Live prices"
        static let coin = "Coin"
        static let holdings = "Holdings"
        static let price = "Price"
        static let marketCap = "Market Cap"
        static let volume = "24h Volume"
        static let btcDominance = "BTC"
        static let portfolioValue = "Portfolio Value"
        static let emptyPortfolioPlaceholder = "You haven't added any coins to your portfolio yeat! Click the + button to get started."
    }

}


//MARK: - Portfolio Screen
extension Constants {
    
    struct Portfolio {
        static let editPortfolio = "Edit portfolio"
        static let coins = "Coins"
        static let curentPrice = "Current price of"
        static let amountHolding = "Amount holding:"
        static let currentValue = "Current value:"
        static let saveButton = "Save"
    }
    
}


//MARK: - Detail Screen
extension Constants {
   
    struct Detail {
        static let overview = "Overview"
        static let additional = "Additional Details"
        static let currentPrice = "Current Price"
        static let marketCapitalization = "Market Capitalization"
        static let rank = "Rank"
        static let volume = "Volume"
        static let highHour = "24h High"
        static let lowHour = "24h Low"
        static let hourPriceChange = "24h Price Change"
        static let hourMarketCapChange = "24h Market Cap Change"
        static let blockTime = "Block Time"
        static let hashingAlgorithm = "Hashing Algorithm"
        static let less = "Less"
        static let readMore = "Read more"
    }
    
}


//MARK: - Settings Screen
extension Constants {
    
    struct Settings {
        static let title = "Settings"
        static let aboutApp = "About App"
        static let customization = "Customization"
        static let lightAppearance = "Light Appearance"
        static let darkAppearance = "Dark Appearance"
        static let app = "Application"
        static let aboutAppDescr =
        "This app uses MVVM Architecture, Combine, and CoreData! It was made by using the cryptocurrency data from a free API from CoinGecko! Prices may be slightly delayed."
        static let customizationDescr = "If you wish, you can change the application Appearance by toggle the switch in this box."
    }
    
    struct SettingsInput {
        static let dev = "Developer"
        static let compatibility = "Compatibility"
        static let swiftUI = "SwiftUI"
        static let sourceCode = "Source code"
        static let api = "API"
        static let devContent = "Yuliia Pashko"
        static let compatibilityContent = "iOS 15.2"
        static let swiftUIContent = "3.0"
        static let sourceCodeContent = "GitHub"
        static let apiContent = "CoinGecko"
    }
    
}


//MARK: - Icons
//TO DO: - can use image Literal, but now it's does't work in my Xcode version 13.2.1 ¯\_(ツ)_/¯
struct Icon {
    static let chevronDown = "chevron.down"
    static let goforward = "goforward"
    static let arrow = "arrow"
    static let plus = "plus"
    static let info = "info"
    static let xmark = "xmark"
    static let magnifyingglass = "magnifyingglass"
    static let xmarkCircleFill = "xmark.circle.fill"
    static let questionmark = "questionmark"
    static let triangleFill = "triangle.fill"
    static let checkmark = "checkmark"
    static let arrowUpRightSquare = "arrow.up.right.square"
}



// LAYOUT for portfolio
let columnSpacing: CGFloat = 10
let rowSpacing: CGFloat = 10
var gridLayout: [GridItem] {
  return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
}

var gridLayout2: [GridItem] {
  return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 1)
}


