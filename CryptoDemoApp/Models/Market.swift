//
//  MarketData.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 20.11.2022.
//

import Foundation

/*
 https://api.coingecko.com/api/v3/global
 */

struct GlobalData: Codable {
    let data: Market?
}

struct Market: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    var marketCap: String {
        if let item = totalMarketCap.first (where: { $0.key ==
            "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first (where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPercentString()
        }
        return ""
    }
}
