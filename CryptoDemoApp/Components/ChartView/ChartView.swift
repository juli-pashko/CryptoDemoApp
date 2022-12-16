//
//  ChartView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 27.11.2022.
//

import SwiftUI

struct ChartView: View {
    
    //MARK: - Properties
    @State private var percentage: CGFloat = 0
    var isShowDetailView: Bool
    
    private let data: [Double]
    private let maxY: Double // higher price
    private let minY: Double //lower price
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    
    //MARK: - Initialization
    init(coin: Coin, isShowDetailView: Bool = true) {
        self.isShowDetailView = isShowDetailView
        
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChage = (data.last ?? 0) - (data.first ?? 0) // positive or negative price on the graph
      
        if isShowDetailView {
            lineColor = priceChage > 0 ? Color.theme.green : Color.theme.red
        } else {
            lineColor = Color.theme.secondaryText.opacity(0.5)
        }
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    
    //MARK: - Body
    var body: some View {
        content
    }
    
}


//MARK: - ChartView_Previews
struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}


//MARK: - ChartView Extension
extension ChartView {
    
   @ViewBuilder
    private var content: some View {
        if isShowDetailView {
            animatedChartView
        } else {
            rowChartView
            .frame(maxWidth: UIScreen.main.bounds.width / 3.5)
        }
    }
    
    //MARK: Views
    private var animatedChartView: some View {
        VStack{
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxis.padding(.horizontal, 4), alignment: .leading)
            
            chartDatelabels
                .padding(.horizontal, 4)
        }//: VStack
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
            }
        }//: onAppear
    }
    
    private var chartView: some View {
        GeometryReader { geometry in
            calculateThePath(by: geometry)
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40)
        }
    }
    
    private var rowChartView: some View {
        GeometryReader { geometry in
            calculateThePath(by: geometry)
            .stroke(lineColor , style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack{
            Text(maxY.formattedWithAbbreviations())//max
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())//mid
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDatelabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
    
    /// Calculate the path for the chart view line
    ///```
    ///  let xPosition:
    ///  300 -> UIScreen.main.bounds.width or the same is geometry.size.width
    ///  100 -> CGFloat(data.count)
    ///  were (1) -> it's index+ * 3 = 3
    ///  2 * 3 = 6
    ///  3 * 3 = 9
    ///  100 * 3 = 300
    ///
    ///```
    ///```
    ///  let yAxis = range beetwen (higher) maxY and (lower) minY price
    ///  50,000 - max
    ///  40,000 - min
    ///  50,000 - 40,000 = 10,000 (yAxis)
    ///
    ///```
    ///```
    ///  let yPosition = CGFloat((data[index] - minY) / yAxis) * geometry.size.height
    ///  42,000 - data point [data.index] in loop
    ///  data.point - mim
    ///  42,000 - 40,000 = 2,000 of the bottom
    ///  2,000 / 10,000 = 20%
    ///  data.point = 20% at the bottom of the screen
    ///  (1 - CGFloat((data[index] - minY) / yAxis)) - reverse (because the main system in iphone has zero point at the top of the screen)
    ///
    ///```
    
    func calculateThePath(by geometry: GeometryProxy) -> Path {
        Path { path in
            for index in data.indices {
                let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
              
                let yAxis = maxY - minY
               
                let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
               
                if index == 0 {
                    path.move(to: CGPoint(x: xPosition, y: yPosition))
                }
                path.addLine(to: CGPoint(x: xPosition, y: yPosition))
            }
        }
    }
    
}
