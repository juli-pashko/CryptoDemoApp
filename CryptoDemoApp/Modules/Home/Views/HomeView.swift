//
//  HomeView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 17.11.2022.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: - Properties
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var isShowPortfolio: Bool = false // animate right
    @State private var isShowPortfolioView: Bool = false // new sheet
    @State private var isShowSettingsView: Bool = false // new sheet
    @State private var selectedCoin: Coin? = nil
    @State private var isShowDetailView: Bool = false //for custom segue func
     
    
    //MARK: - Body
    var body: some View {
        ZStack {
            //background layer
            Color.theme.background.ignoresSafeArea()
                .sheet(isPresented: $isShowPortfolioView) {
                    PortfolioView()
                        .environmentObject(viewModel)
                }

            //content layer
            VStack {
                headerView
                statisticView
                columnTitles
                
                if !isShowPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if isShowPortfolio {
                    ZStack(alignment: .top) {
                        if viewModel.portfolioCoins.isEmpty && viewModel.searchText.isEmpty {
                            portfolioPlaceholder
                        }
                    }//: ZStack
                    portfolioCoinsList
                    .transition(.move(edge: .trailing))
                  
                }

                searchBar
                Spacer(minLength: 0)
            }//: VStack
        
            
            .sheet(isPresented: $isShowSettingsView) {
                SettingsView()
            }
      
        }//: ZStack
        .background (
            navigationLink
        )
        .customNavigationTitle(isShowPortfolio ? Constants.Home.portfolio.uppercased() : Constants.Home.livePrices.uppercased())
    }
}


//MARK: - HomeView_Previews
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView {
            HomeView()
        }.environmentObject(dev.homeViewModel)
    }
}


//MARK: - HomeView Header
extension HomeView {
    
    private var headerView: some View {
        HStack {
            rightHeaderButton
            Spacer()
            headerTitle
            Spacer()
            leftHeaderButton
        }//: HStack
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
    }
    
    private var headerTitle: some View {
        Text(isShowPortfolio ? Constants.Home.portfolio.uppercased() : Constants.Home.livePrices.uppercased())
            .withCustomTitleModifire()
            .foregroundColor(Color.theme.accent)
            .animation(.none)
    }
    
    private var leftHeaderButton: some View {
        CircleButtonView(iconeName: Icon.arrow)
            .rotationEffect(Angle(degrees: isShowPortfolio ? 180 : 0))
            .onTapGesture {
                withAnimation(.spring()) {
                    isShowPortfolio.toggle()
                }
            }
    }
    
    private var rightHeaderButton: some View {
        CircleButtonView(iconeName: isShowPortfolio ? Icon.plus : Icon.info)
            .animation(.none)
            .background(
                CircleButtonAnimationView(isAnimating: $isShowPortfolio)
            )
            .onTapGesture {
                if isShowPortfolio {
                    isShowPortfolioView.toggle()
                } else {
                    isShowSettingsView.toggle()
                }
            }
    }
    
}


//MARK: - HomeView Lists
extension HomeView {
    
    private var allCoinsList: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: -15))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }//: List
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }//: List
        .listStyle(.plain)
    }
    
    private var portfolioPlaceholder: some View {
     Text(Constants.Home.emptyPortfolioPlaceholder)
        .font(.mainFont(ofSize: 14, weight: .regular))
        .foregroundColor(Color.theme.secondaryText)
        .multilineTextAlignment(.center)
        .padding()
    }
    
    //Before Apple creates Lazy NavigationLink, we can use another way with segue
    private func segue(coin: Coin) {
        selectedCoin = coin
        isShowDetailView.toggle()
    }
 
}
    

//MARK: - HomeView Column Titles
extension HomeView {
   
    private var columnTitles: some View {
        HStack {
            coinView
            Spacer()
            
            if isShowPortfolio {
                holdingsView
            }
//            Spacer()
            priceView
            refreshButton

        }//: HStack
        .font(.mainFont(ofSize: 14, weight: .regular))
        .foregroundColor(Color.theme.secondaryText)
        .frame(height: 30)
        .padding(.horizontal)
    }
    
    private var coinView: some View {
        HStack(spacing: 4) {
            Text(Constants.Home.coin)
            Image(systemName: Icon.chevronDown)
                .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1.0 : 0.0 )
                .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 180: 0))
        }//: HStack
        .onTapGesture {
            withAnimation(.default) {
                viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
            }
        }
    }
    
    private var holdingsView: some View {
        HStack(spacing: 4) {
            Text(Constants.Home.holdings)
            Image(systemName: Icon.chevronDown)
                .opacity((viewModel.sortOption == .holdings || viewModel.sortOption == .holdingsReversed) ? 1.0 : 0.0 )
                .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 180: 0))
        }//: HStack
        .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
        .onTapGesture {
            withAnimation(.default) {
                viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingsReversed : .holdings
            }
        }
    }
    
    private var priceView: some View {
        HStack(spacing: 4) {
            Text(Constants.Home.price)
            Image(systemName: Icon.chevronDown)
                .opacity((viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ? 1.0 : 0.0 )
                .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 180: 0))
        }//: HStack
        .frame(width: UIScreen.main.bounds.width / 3, alignment: .trailing)
        .onTapGesture {
            withAnimation(.default) {
                viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
            }
        }
    }
    
    private var refreshButton: some View {
        Button {
            withAnimation(.linear) {
                viewModel.reloadData()
            }
        } label: {
            Image(systemName: Icon.goforward)
        }
        .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0), anchor: .center)
    }

}


//MARK: - HomeView
extension HomeView {
   
    private var statisticView: some View {
        HomeStatisticView(isShowPortfolio: $isShowPortfolio)
    }
    
    private var searchBar: some View {
        SearchBarView(searchText: $viewModel.searchText)
        .padding()
    }
    
    private var navigationLink: some View {
        CustomNavigationLink(
         destination: DetailLoadingView(coin: $selectedCoin),
         isActive: $isShowDetailView,
         label: { EmptyView() })
    }
    
}
