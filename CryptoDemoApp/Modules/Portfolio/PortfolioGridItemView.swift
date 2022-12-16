//
//  PortfolioCoinView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 30.11.2022.
//

import SwiftUI

struct PortfolioGridItemView: View {
    
    //MARK: - Properties
    let coin: Coin
    
    
    //MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            coinIcone
            coinSymbol
            Spacer()
        } //: HSTACK
        .padding()
        .background(
            backgroundView
        )
    }

}


//MARK: - PortfolioCoinView_Previews
struct PortfolioCoinView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PortfolioGridItemView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color.theme.accent)
                .preferredColorScheme(.light)
            
            PortfolioGridItemView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color.theme.accent)
                .preferredColorScheme(.dark)
        }
    }
}


//MARK: - PortfolioCoinView Extention
extension PortfolioGridItemView {
    
    private var coinIcone: some View {
        CoinImageView(coin: coin)
            .frame(width: 30, height: 30, alignment: .center)
    }
    
    private var coinSymbol: some View {
        Text(coin.symbol.uppercased())
            .font(.mainFont(ofSize: 16, weight: .medium))
            .foregroundColor(Color.theme.accent)
    }
    
    private var backgroundView : some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.theme.secondaryText.opacity(0.5), lineWidth: 1)
            .background(Color.theme.secondaryText.opacity(0.15))
            .cornerRadius(12)
    }
    
}
