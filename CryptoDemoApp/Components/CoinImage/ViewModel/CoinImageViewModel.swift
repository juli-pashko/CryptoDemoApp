//
//  CoinImageViewModel.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 19.11.2022.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: Coin
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    
    //MARK: - Initialization
    init(coin: Coin) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isLoading = true
    }
    
    
    //MARK: - Private methods
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                guard let self = self else { return }
                self.image = returnedImage
            }
            .store(in: &cancellables)
    }
    
}
