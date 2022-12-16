//
//  CoinRowView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 18.11.2022.
//

import SwiftUI

struct CoinRowView: View {
    
    //MARK: - Properties
    let coin: Coin
    let showHoldingColumn: Bool
    
    
    //MARK: - Body
    var body: some View {
        HStack {
            leftColumn
            if showHoldingColumn {
               centerColumn
            } else {
                ChartView(coin: coin, isShowDetailView: false)
            }
            rightColumn
        }//: HStack
        .frame(maxWidth: .infinity)
        .background(Color.theme.background.opacity(0.001))
    }
}


//MARK: - CoinRowView_Previews
struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, showHoldingColumn: false)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}


extension CoinRowView {
    
    //MARK: - Columns
    private var leftColumn: some View {
            HStack(spacing: 4) {
                //Rank
                Text(String(coin.rank))
                    .font(.mainFont(ofSize: 12, weight: .regular))
                    .foregroundColor(Color.theme.accent)
                    .frame(width: 20, alignment: .leading)
                //Logo
                CoinImageView(coin: coin)
                    .frame(width: 24, height: 24)
                //BTC
                Text(coin.symbol.uppercased())
                    .font(.mainFont(ofSize: 16, weight: .semibold))
                    .foregroundColor(Color.theme.accent)
                HStack() {
                    Spacer()
                }
            }//: HStack
            .padding(.leading, 16)
            .frame(minWidth: UIScreen.main.bounds.width / 3)
    }
    
    private var centerColumn: some View {
            VStack(alignment: .center) {
                Text(coin.currentHoldingsVaue.asCurrencyWith2Demicals())
                    .font(.mainFont(ofSize: 16, weight: .medium))
                    .foregroundColor(Color.theme.accent)
                Text((coin.currentHoldings ?? 0).asNumberString())
                    .font(.mainFont(ofSize: 14, weight: .regular))
                    .foregroundColor(Color.theme.secondaryText)
                HStack() {
                    Spacer()
                }
            }//: VStack
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .frame(minWidth: UIScreen.main.bounds.width / 3)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Demicals())
                .font(.mainFont(ofSize: 16, weight: .medium))
                .foregroundColor(Color.theme.accent)
                
            Text(coin.priceChangePercentage24H.asPercentString())
                .font(.mainFont(ofSize: 14, weight: .medium))
                .foregroundColor(
                    coin.priceChangePercentage24H >= 0 ?
                    Color.theme.green : Color.theme.red
                )
            HStack() {
                Spacer()
            }
        }//: VStack
        .padding(.trailing, 30)
        .frame(minWidth: UIScreen.main.bounds.width / 3)
    }
    
}


