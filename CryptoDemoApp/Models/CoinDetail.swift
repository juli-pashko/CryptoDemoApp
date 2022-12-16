//
//  CoinDetail.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 26.11.2022.
//

import Foundation

/*
 URL: https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false
  */

struct CoinDetail: Codable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    
    var readableDescription: String? {
        return description?.en?.removingHTMLOccurances 
    }
}

struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
}

struct Description: Codable {
    let en: String?
}
