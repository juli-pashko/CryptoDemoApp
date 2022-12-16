//
//  MarketDataService.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 21.11.2022.
//

import Foundation
import Combine


class MarketDataService {
    
    //MARK: - Properties
    @Published var markerData: Market? = nil
    private var marketDataSubscriptions: AnyCancellable?
    
    
    //MARK: - Initialization
    init() {
        getMarketData()
    }
    
    
    //MARK: - Public methods
    func getMarketData() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        marketDataSubscriptions = NetworkingManager.download(url: APIRouter.getMarketData.url)
            .decode(type: GlobalData.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                guard let self = self else { return }
                self.markerData = returnedGlobalData.data
                self.marketDataSubscriptions?.cancel()
            })
    }
}

