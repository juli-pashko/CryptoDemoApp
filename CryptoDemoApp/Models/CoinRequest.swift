//
//  CoinRequest.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 13.12.2022.
//

import Foundation

struct CoinRequest {
    var query: [URLQueryItem] {
        return [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "order", value: "market_cap_desc"),
            URLQueryItem(name: "per_page", value: "50"),
            URLQueryItem(name: "sparkline", value: "true"),
            URLQueryItem(name: "price_change_percentage", value: "24h")
        ]
    }
}
