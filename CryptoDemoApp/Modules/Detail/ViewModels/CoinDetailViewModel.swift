//
//  CoinDetailViewModel.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 26.11.2022.
//

import Foundation
import Combine

class CoinDetailViewModel: ObservableObject {
    
    //MARK: Published
    @Published var coin: Coin
    @Published var overviewStatistics: [Statistic] = []
    @Published var additionalStatistics: [Statistic] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil
    
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    
    //MARK: - Initialization
    init(coin: Coin) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    
    //MARK: - Subscribers
    private func addSubscribers() {
        
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink(receiveValue: { [weak self] returnedArray in
                guard let self = self else { return }
                self.overviewStatistics = returnedArray.overview
                self.additionalStatistics = returnedArray.additional
            })
            .store(in: &cancellables)
        
        coinDetailService.$coinDetails
            .sink { [weak self] returnedCoinDetails in
                guard let self = self else { return }
                self.coinDescription = returnedCoinDetails?.readableDescription 
                self.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    
    //MARK: - Private methods
    private func mapDataToStatistics(coinDetail: CoinDetail?, coin: Coin) -> (overview: [Statistic], additional: [Statistic]) {
        let overviewArray = createOverviewArray(coin: coin)
        let additionalArray = createAdditionalArray(coinDetail: coinDetail, coin: coin)
        return (overviewArray , additionalArray)
    }
    
    private func createOverviewArray(coin: Coin) -> [Statistic] {
        
        let price = coin.currentPrice.asCurrencyWith6Demicals()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStat = Statistic(title: Constants.Detail.currentPrice, value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStat = Statistic(title: Constants.Detail.marketCapitalization, value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coin.rank)"
        let rankStat = Statistic(title: Constants.Detail.rank, value: rank)
        
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistic(title: Constants.Detail.volume, value: volume)
        
        let overviewArray: [Statistic] = [
            priceStat, marketCapStat, rankStat, volumeStat
        ]
        
       return overviewArray
    }
    
    private func createAdditionalArray(coinDetail: CoinDetail?, coin: Coin) -> [Statistic] {
      
        let high = coin.high24H?.asCurrencyWith6Demicals() ?? "n/a"
        let highStat = Statistic(title: Constants.Detail.highHour, value: high)
        let low = coin.low24H?.asCurrencyWith6Demicals() ?? "n/a"
        let lowStat = Statistic(title: Constants.Detail.lowHour, value: low)
      
        let priceChange = coin.priceChange24H?.asCurrencyWith6Demicals() ?? "n/a"
        let pricePercentChange2 = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(title: Constants.Detail.hourPriceChange, value: priceChange, percentageChange: pricePercentChange2)
      
        let marketCapChange = "S" + (coin.marketCapChange24H? .formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: Constants.Detail.hourMarketCapChange, value: marketCapChange, percentageChange: marketCapPercentChange2)
      
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a": "\(blockTime)"
        let blockStat = Statistic(title: Constants.Detail.blockTime, value: blockTimeString)
        
        let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(title: Constants.Detail.hashingAlgorithm, value: hashing)
        
        let additionalArray: [Statistic] = [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat
        ]
        
        return additionalArray
    }
    
    
}
