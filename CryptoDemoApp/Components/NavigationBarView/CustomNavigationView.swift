//
//  NavigationView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 06.12.2022.
//

import SwiftUI

struct CustomNavigationView<Content: View>: View {
    
    //MARK: - Properties
    let content: Content
    
    
    //MARK: - Initialization
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    
    //MARK: Body
    var body: some View {
        NavigationView {
            NavigationBarContainerView {
                content
            }//: CustomNavBarContainerView
            .navigationBarHidden(true)
        }//: NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    }

}


//MARK: - NavigationView_Previews
struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView {
            Color.green.opacity(0.3).ignoresSafeArea()
        }
    }
}


//MARK: - UINavigationController
extension UINavigationController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
    
}
