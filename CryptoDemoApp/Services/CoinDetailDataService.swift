//
//  CoinDetailDataService.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 26.11.2022.
//

import Foundation
import Combine
import UIKit

protocol CoinDetailDataServiceProtocol {
    var service: CoinDetailDataService { get }
}

class CoinDetailDataService {
    
    //MARK: - Properties
    @Published var coinDetails: CoinDetail? = nil
    private var coinDetailSubscriptions: AnyCancellable?
    let coin: Coin
    
    
    //MARK: - Initialization
    init(coin: Coin) {
        self.coin = coin
        getCoinDetailData()
    }
    
    
    //MARK: - Public methods
    func getCoinDetailData() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        coinDetailSubscriptions = NetworkingManager.download(url: APIRouter.getCoinDetailData(id: coin.id).url)
            .decode(type: CoinDetail.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetail) in
                guard let self = self else { return }
                self.coinDetails = returnedCoinDetail
                self.coinDetailSubscriptions?.cancel()
            })

    }
    
}

