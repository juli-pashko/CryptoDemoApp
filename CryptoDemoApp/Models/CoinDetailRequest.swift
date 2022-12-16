//
//  CoinDetailRequest.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 13.12.2022.
//

import Foundation

struct CoinDetailRequest {
    var query: [URLQueryItem] {
        return [
            URLQueryItem(name: "tickers", value: "false"),
            URLQueryItem(name: "market_data", value: "false"),
            URLQueryItem(name: "community_data", value: "false"),
            URLQueryItem(name: "developer_data", value: "false"),
            URLQueryItem(name: "sparkline", value: "false")
        ]
    }
}
