//
//  CircleButtonView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 17.11.2022.
//

import SwiftUI

struct CircleButtonView: View {
    
    //MARK: - Properties
    let iconeName: String
    
    
    //MARK: - Body
    var body: some View {
        Image(iconeName)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.background.opacity(0.0001))
            )
    }

}


//MARK: - CircleButtonView_Previews
struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconeName: "info")
            .previewLayout(.sizeThatFits)
            
            CircleButtonView(iconeName: "plus")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        }//: Group
    }
}
