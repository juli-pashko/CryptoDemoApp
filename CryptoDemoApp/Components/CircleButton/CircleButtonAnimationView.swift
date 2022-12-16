//
//  CircleButtonAnimationView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 17.11.2022.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    //MARK: - Properties
    @Binding var isAnimating: Bool
    
    
    //MARK: - Body
    var body: some View {
        Circle()
            .stroke(lineWidth: 3)
            .scale(isAnimating ? 1.0 : 0.0)
            .opacity(isAnimating ? 0.0 : 1.0)
            .animation(isAnimating ? Animation.easeOut(duration: 1.0) : .none)
    }

}


//MARK: - CircleButtonAnimationView_Previews
struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(isAnimating: .constant(false))
            .frame(width: 100, height: 100)
            .foregroundColor(.red)
    }
}
