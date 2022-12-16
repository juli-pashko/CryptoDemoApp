//
//  HomeViewModel.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 18.11.2022.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    //MARK: Published
    @Published var statistics: [Statistic] = []
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    
    
    //MARK: Servises
    private let coinDataService = CoinDataServices()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    
    //MARK: - Initialization
    init() {
        addSubscribers()
    }
    
    
    //MARK: - Subscribers
    private func addSubscribers() {
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        //update portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        //updates market data
        marketDataService.$markerData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                guard let self = self else { return }
                self.statistics = returnedStats
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    
    //MARK: - Public methods
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoinsData()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
    
    
    //MARK: - Private methods
    private func filterAndSortCoins(text: String, coins: [Coin], sort: SortOption) -> [Coin] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
        
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func sortCoins(sort: SortOption, coins: inout [Coin]) {
        switch sort {
        case .rank, .holdings:
             coins.sort(by: {$0.rank < $1.rank })
        case .rankReversed, .holdingsReversed:
             coins.sort(by: {$0.rank > $1.rank })
        case .price:
             coins.sort(by: {$0.currentPrice > $1.currentPrice })
        case .priceReversed:
             coins.sort(by: {$0.currentPrice < $1.currentPrice })
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin] {
        //will only sort by holdings or reserved holdings if needed
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsVaue > $1.currentHoldingsVaue })
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsVaue < $1.currentHoldingsVaue })
        default:
            return coins
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [Coin], portfolioEntities: [PortfolioEntity]) -> [Coin] {
        allCoins
            .compactMap { (coin) -> Coin? in
            guard let entity = portfolioEntities.first(where: {$0.coinId == coin.id}) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    private func mapGlobalMarketData(marketData: Market?, portfolioCoins: [Coin]) -> [Statistic] {
        var stats: [Statistic] = []
        guard let data = marketData else { return stats }
        
        let marketCap = Statistic(title: Constants.Home.marketCap, value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: Constants.Home.volume, value: data.volume)
        let btcDominance = Statistic(title: Constants.Home.btcDominance, value: data.btcDominance)
        
        let portfolioValue =
        portfolioCoins
            .map({$0.currentHoldingsVaue})
            .reduce(0, +)
        
        let previousValue =
        portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsVaue
                let percentChange = coin.priceChangePercentage24H / 100
                let previusValue = currentValue / (1 + percentChange)
                return previusValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
      
        let portfolio = Statistic(
            title: Constants.Home.portfolioValue,
            value: portfolioValue.asCurrencyWith2Demicals(),
            percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }

}
