//
//  PortfolioView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 21.11.2022.
//

import SwiftUI

struct PortfolioView: View {

    //MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    @State private var isShowCheckmark: Bool = false
    @State private var scrollViewOffset: CGFloat = 0.0
        

    //MARK: - Body
    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    headerView
                        .opacity(Double(scrollViewOffset) / 103)
                    SearchBarView(searchText: $viewModel.searchText).padding()
                    coinsGrid
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }//: VStack
            }//: ScrollView
            .font(.mainFont(ofSize: 20, weight: .bold))
            .onChange(of: viewModel.searchText) { newValue in
                if newValue.isEmpty {
                    removeSelectedCoin()
                }
            }
            .overlay(
                navBarLayer
                    .opacity(scrollViewOffset < 40 ? 1.0 : 0.0)
                , alignment: .top
            )

    }
}


//MARK: - PortfolioView_Previews
struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}


//MARK: - PortfolioView Extension
extension PortfolioView {
    
    //MARK: Views
    private var headerView: some View {
        HStack {
            Text(Constants.Portfolio.editPortfolio.uppercased())
                .font(.mainFont(ofSize: 24, weight: .bold))
                .onScrollViewChange { offset in
                    self.scrollViewOffset = offset
                    print(offset)
                }
            Spacer()
            HStack(spacing: 8) {
                trailingNavBarButton
                closeButton
            }
        }//: HStack
        .padding(EdgeInsets(top: 30, leading: 16, bottom: 8, trailing: 16))
    }
    
    private var navBarLayer: some View {
        Text(Constants.Portfolio.editPortfolio.uppercased())
            .font(.mainFont(ofSize: 16, weight: .bold))
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Color.theme.headerSheet)
    }
    
    private var coinsGrid: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHGrid(rows: gridLayout, alignment: .center, spacing: columnSpacing, pinnedViews: [], content: {
                Section(header: SectionView(title: Constants.Portfolio.coins, rotateClockwise: false)) {
                    coinsLogoList
                  }
            })//: Grid
                .frame(height: 140)
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 16))
        })//: ScrollView
    }
    

    private var coinsLogoList: some View {
        ForEach(viewModel.searchText.isEmpty && !viewModel.portfolioCoins.isEmpty ? viewModel.portfolioCoins : viewModel.allCoins) { coin in
            PortfolioGridItemView(coin: coin)
                .onTapGesture {
                    withAnimation(.easeIn) {
                        UIApplication.shared.endEditing()
                        updateSelectedCoin(coin: coin)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                )
        }//: Loop
    }
    

    //MARK: - Input Sections
    private var currentPriceSection: some View {
        HStack {
            Text("\(Constants.Portfolio.curentPrice) \(selectedCoin?.symbol.uppercased() ?? ""):")
                .font(.mainFont(ofSize: 16, weight: .regular))
            Spacer()
            Text(selectedCoin?.currentPrice.asCurrencyWith6Demicals() ?? "")
                .font(.mainFont(ofSize: 17, weight: .medium))
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var amountHoldingSection: some View {
        HStack {
            Text(Constants.Portfolio.amountHolding)
                .font(.mainFont(ofSize: 16, weight: .regular))
            Spacer()
            TextField("Ex: 1.4", text: $quantityText)
                .font(.mainFont(ofSize: 17, weight: .medium))
                .foregroundColor(Color.theme.accent)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
        }
    }
    
    private var currentValueSection: some View {
        HStack{
            Text(Constants.Portfolio.currentValue)
            .font(.mainFont(ofSize: 16, weight: .regular))
            Spacer()
            Text(getCurrentValue().asCurrencyWith2Demicals())
            .font(.mainFont(ofSize: 17, weight: .medium))
            .foregroundColor(Color.theme.accent)
        }
    }
    
    private var portfolioInputSection: some View {
        GroupBox {
            VStack(spacing: 25) {
            currentPriceSection
            Divider()
            amountHoldingSection
            Divider()
            currentValueSection
            }
        }
        .padding()
    }

    
    //MARK: Controls
    private var trailingNavBarButton: some View {
        HStack(spacing: 10) {
            Image(systemName: Icon.checkmark)
                .opacity(isShowCheckmark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text(Constants.Portfolio.saveButton.uppercased())
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
            )
        }//: HStack
        .font(.mainFont(ofSize: 16, weight: .bold))
    }
    
    private var closeButton: some View {
        Button(action: {
           presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: Icon.xmark)
           .font(.headline)
        })
    }
    
}


//MARK: - Helphul func
extension PortfolioView {
    
    private func updateSelectedCoin(coin: Coin) {
        selectedCoin = coin
        if let portfolioCoin = viewModel.portfolioCoins.first(where: {$0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText.removeAll()
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText.removeAll()
        quantityText.removeAll()
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity + (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin,
              let amount = Double(quantityText)
        else { return }
        // save to portfolio
        print(coin)
        viewModel.updatePortfolio(coin: coin, amount: amount)
        
        //save check mark
        withAnimation {
            isShowCheckmark = true
            removeSelectedCoin()
        }
        
        //hide keyboard
        UIApplication.shared.endEditing()
        
        //hide checkmarks
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                isShowCheckmark = false
            }
        }
    }
    
}
