//
//  CoinDataServices.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 18.11.2022.
//

import Foundation
import Combine
import UIKit


class CoinDataServices {
    
    //MARK: - Properties
    @Published var allCoins: [Coin] = []
    private var coinSubscriptions: AnyCancellable?
    
    
    //MARK: - Initialization
    init() {
        getCoinsData()
    }
    
    
    //MARK: - Public methods
    func getCoinsData() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        coinSubscriptions = NetworkingManager.download(url: APIRouter.getCoinsData.url)
            .decode(type: [Coin].self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.allCoins = returnedCoins
                self.coinSubscriptions?.cancel()
            })
    }
    
}
