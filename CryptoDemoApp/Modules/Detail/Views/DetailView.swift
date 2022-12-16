//
//  DetailView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 25.11.2022.
//

import SwiftUI

struct DetailLoadingView: View {
    
    //MARK: - Properties
    @Binding var coin: Coin?
    
    
    //MARK: - Body
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }//: ZStack
    }
    
}

struct DetailView: View {
    
    //MARK: - Properties
    @StateObject private var viewModel: CoinDetailViewModel
    @State private var isShowFullDescription: Bool = false
    private let spacing: CGFloat = 20
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    
    //MARK: - Initialization
    init(coin: Coin) {
        self._viewModel = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
    }
    
    
    //MARK: - Body
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: viewModel.coin)
                    .padding(.vertical)
               
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteSection
                }//: VStack
                .padding()
            }//: VStack
        }//: ScrollView
        .customNavigationTitle(viewModel.coin.name.uppercased())
    }
}


//MARK: - DetailView_Previews
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView {
            DetailView(coin: dev.coin)
        }
    }
}


//MARK: - DetailView Extension
extension DetailView {
    
    //MARK: - Titles
    private var headerView: some View {
        HStack {
            Text(viewModel.coin.name.uppercased())
                .withCustomTitleModifire()
            Spacer()
        }//: HStack
        .padding(EdgeInsets(top: 30, leading: 16, bottom: 8, trailing: 16))
    }
    
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle: some View {
        Text(Constants.Detail.overview)
            .withCustomTitleModifire(alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text(Constants.Detail.additional)
            .withCustomTitleModifire(alignment: .leading)
    }
    
    
    //MARK: - Sections
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = viewModel.coinDescription,
               !coinDescription.isEmpty {
                
                VStack(alignment: .leading) {
                
                Text(coinDescription)
                    .lineLimit(isShowFullDescription ? nil : 3)
                    .font(.mainFont(ofSize: 16, weight: .regular))
                    .foregroundColor(Color.theme.secondaryText)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            isShowFullDescription.toggle()
                        }
                    } label: {
                        Text(isShowFullDescription ? Constants.Detail.less : Constants.Detail.readMore)
                            .font(.mainFont(ofSize: 12, weight: .bold))
                            .padding(.vertical, 4)
                    }//: Button
                    .accentColor(.blue)

                }//: VStack
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading) {
            if let websiteString = viewModel.websiteURL,
               let url = URL(string: websiteString) {
                Link("Website", destination: url)
            }
        }//: VStack
        .font(.mainFont(ofSize: 12, weight: .bold))
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    
    //MARK: - Grid
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(viewModel.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }//: Loop
            }
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(viewModel.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }//: Loop
            }
    }
    
}



