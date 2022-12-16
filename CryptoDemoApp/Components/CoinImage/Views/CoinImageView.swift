//
//  CoinImageView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 19.11.2022.
//

import SwiftUI


struct CoinImageView: View {
    
    //MARK: - Properties
    @StateObject var viewModel: CoinImageViewModel
    
    
    //MARK: - Initialization
    init(coin: Coin) {
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    
    //MARK: - Body
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: Icon.questionmark)
                    .foregroundColor(Color.theme.secondaryText)
            }
        }//: ZStack
    }

}


//MARK: - CoinImageView_Previews
struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
