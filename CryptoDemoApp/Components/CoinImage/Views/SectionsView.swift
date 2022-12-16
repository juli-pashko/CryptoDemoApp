//
//  SectionsView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 30.11.2022.
//

import SwiftUI

struct SectionView: View {
    // MARK: - Properties
    let title: String
    @State var rotateClockwise: Bool
    
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            selectionTitle
            Spacer()
        } //: Vstack
        .background(
            Color.theme.secondaryText.opacity(0.15)
                .cornerRadius(12)
        )
        .frame(width: 85)
    }

}


// MARK: - SectionView_Previews
struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(title: "Coins", rotateClockwise: true)
            .previewLayout(.fixed(width: 120, height: 240))
            .padding()
            .background(Color.theme.accent)
    }
}


// MARK: - SectionView Extention
extension SectionView {
    
    private var selectionTitle: some View {
        Text(title.uppercased())
            .font(.mainFont(ofSize: 16, weight: .medium))
            .foregroundColor(Color.theme.accent)
            .rotationEffect(Angle(degrees: rotateClockwise ? 90 : -90))
    }
    
}

