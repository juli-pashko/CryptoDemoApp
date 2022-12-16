//
//  LaunchView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 28.11.2022.
//

import SwiftUI

struct LaunchView: View {
    
    //MARK: - Properties
    @State private var loadingText: [String] = "Loading your portfolio...".map{ String($0) }
    @State private var isShowLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var isShowLaunchView: Bool
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.launch.background.ignoresSafeArea()
            logoImage
            ZStack {
                if isShowLoadingText {
                    loadingTextView
                }
            }//: ZStack
            .offset(y: 70)
        }//: ZStack
        .onAppear {
            isShowLoadingText.toggle()
        }//: onAppear
        .onReceive(timer) { _ in
            withAnimation {
                calculateScreenDisplay()
            }
        }//: onReceive
    }
}


//MARK: - LaunchView_Previews
struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(isShowLaunchView: .constant(true))
    }
}


//MARK: - LaunchView Extension
extension LaunchView {
    
    private var logoImage: some View {
        Image("settingsLogoDark")
            .resizable()
            .frame(width: 80, height: 80)
    }
    
    private var loadingTextView: some View {
        HStack(spacing: 0) {
            ForEach(loadingText.indices) { index in
                Text (loadingText[index])
                    .font(.mainFont(ofSize: 16, weight: .medium))
                    .foregroundColor(Color.launch.accent)
                    .offset(y: counter == index ? -5 : 0)
            }//: Loop
        }//: HStack
        .transition(AnyTransition.scale.animation(.easeIn))
    }
    
    
    ///calculate when the text animates twice and after that the screen disappears
    private func calculateScreenDisplay() {
        let lastIndex = loadingText.count - 1
        if counter == lastIndex {
            counter = 0
            loops += 1
            if loops >= 2 {
                isShowLaunchView = false
            }
        } else {
            counter += 1
        }
    }
    
}
