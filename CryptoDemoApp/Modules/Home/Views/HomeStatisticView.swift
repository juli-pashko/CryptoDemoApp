//
//  HomeStatisticView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 20.11.2022.
//

import SwiftUI

struct HomeStatisticView: View {
    
    //MARK: - Properties
    @EnvironmentObject private var viewModel: HomeViewModel
    @Binding var isShowPortfolio: Bool
    
    
    //MARK: - Body
    var body: some View {
      ScrollView(.horizontal, showsIndicators: false, content: {
          HStack(spacing: 10) {
              ForEach(viewModel.statistics) { stat in
                  HeaderStatisticView(stat: stat)
              }
          }
        .frame(height: 100)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
      }) //: ScrollView
    }

}


//MARK: - HomeStatisticView_Previews
struct HomeStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatisticView(isShowPortfolio: .constant(false))
            .environmentObject(dev.homeViewModel)
    }
}
