//
//  HeaderStatisticView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 01.12.2022.
//

import SwiftUI

struct HeaderStatisticView: View {
    
    //MARK: - Properties
    let stat: Statistic

    
    //MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            StatisticView(stat: stat)
            Spacer()
        } //: HStack
        .padding()
        .background(
            backgroundView
        )
    }
                   
}


//MARK: - HeaderStatisticView_Previews
struct HeaderStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderStatisticView(stat: dev.stat1)
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color.theme.accent)
                .preferredColorScheme(.light)
            
            HeaderStatisticView(stat: dev.stat2)
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color.theme.accent)
                .preferredColorScheme(.dark)
           
            HeaderStatisticView(stat: dev.stat3)
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color.theme.accent)
                .preferredColorScheme(.dark)
        }
    }
}


//MARK: - HeaderStatisticView Extention
extension HeaderStatisticView {
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.theme.secondaryText.opacity(0.5), lineWidth: 1)
            .background(Color.theme.secondaryText.opacity(0.15))
            .cornerRadius(12)
    }
    
}
