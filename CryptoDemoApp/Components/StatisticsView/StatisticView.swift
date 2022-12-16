//
//  StatisticView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 20.11.2022.
//

import SwiftUI

struct StatisticView: View {
    
    //MARK: - Properties
    let stat: Statistic
    
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            statisticTitle
            statisticValue
            statisticPercentageChangeView
        }//: VStack
    }

}


//MARK: - StatisticView_Previews
struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(stat: dev.stat1)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        
            StatisticView(stat: dev.stat2)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
    
            StatisticView(stat: dev.stat3)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}


//MARK: - StatisticView Extention
extension StatisticView {
    
    private var statisticTitle: some View {
        Text(stat.title)
            .font(.mainFont(ofSize: 14, weight: .medium))
            .foregroundColor(Color.theme.secondaryText)
    }
    
    private var statisticValue: some View {
        Text(stat.value)
            .font(.mainFont(ofSize: 16, weight: .medium))
            .foregroundColor(Color.theme.accent)
    }
    
    private var statisticPercentageChangeView: some View {
        HStack(spacing: 4) {
            Image(systemName: Icon.triangleFill)
                .font(.mainFont(ofSize: 10, weight: .regular))
                .rotationEffect(
                    Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
            Text(stat.percentageChange?.asPercentString() ?? "")
                .font(.mainFont(ofSize: 12, weight: .medium))
        }//: HStack
        .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
    }
}


