//
//  PreviewProvider+.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 18.11.2022.
//

import Foundation
import SwiftUI


extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }

}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() {}
    
    let homeViewModel = HomeViewModel()
    
    let stat1 = Statistic(title: "Market Cap", value: "$11,5Bn", percentageChange: 25.23)
    let stat2 = Statistic(title: "Total Volume", value: "$1.25Tr")
    let stat3 = Statistic(title: "Portfolio Value", value: "$40.5k", percentageChange: -11.23)
    
    let coin = Coin(id: "bitcoin",
                    symbol: "btc",
                    name: "Bitcoin",
                    image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
                    currentPrice: 16743.15,
                    marketCap: 321665004153,
                    marketCapRank: 1,
                    fullyDilutedValuation: 351628929419,
                    totalVolume: 22831128680,
                    high24H: 16994.52,
                    low24H: 16473.58,
                    priceChange24H: 222.72,
                    priceChangePercentage24H: 1.34813,
                    marketCapChange24H: 4174521834,
                    marketCapChangePercentage24H: 1.31485,
                    circulatingSupply: 19210493,
                    totalSupply: 21000000,
                    maxSupply: 21000000,
                    ath: 69045,
                    athChangePercentage: -75.7344,
                    athDate: "2021-11-10T14:24:11.849Z",
                    atl: 67.81,
                    atlChangePercentage: 24607.82671,
                    atlDate: "2013-07-06T00:00:00.000Z",
                    lastUpdated: "2022-11-18T09:51:58.757Z",
                    priceChangePercentage24HInCurrency: 1.348128810120465,
                    sparklineIn7D: SparklineIn7D(price: [56649.9538087876]),
                    currentHoldings: 100)

}


