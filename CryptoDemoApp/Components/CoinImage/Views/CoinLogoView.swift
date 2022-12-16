//
//  CoinLogoView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 21.11.2022.
//

import SwiftUI

struct CoinLogoView: View {
    
    //MARK: - Properties
    let coin: Coin
    
    
    //MARK: - Body
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            coinSymbol
            coinName
        }//: VStack
    }

}


//MARK: - CoinLogoView_Previews
struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
            
            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}


//MARK: - CoinLogoView Extension
extension CoinLogoView {
    
    private var coinSymbol: some View {
        Text(coin.symbol.uppercased())
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
    
    private var coinName: some View {
        Text(coin.name)
            .font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .lineLimit(2)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
    }
    
}
