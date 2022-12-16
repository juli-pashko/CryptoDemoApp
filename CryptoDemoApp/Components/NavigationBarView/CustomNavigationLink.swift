//
//  CustomNavigationLink.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 06.12.2022.
//

import SwiftUI


struct CustomNavigationLink<Label: View, Destination: View> : View {
    
    //MARK: - Properties
    @Binding var isActive: Bool
    let destination: Destination
    let label: Label
 
    
    //MARK: - Initialization
    init(destination: Destination, isActive: Binding<Bool>, @ViewBuilder label: () -> Label) {
        self._isActive = isActive
        self.destination = destination
        self.label = label()
    }
    
    
    //MARK: Body
    var body: some View {
        NavigationLink(
            destination:
            NavigationBarContainerView {
                destination
            }//: CustomNavBarContainerView
            .navigationBarHidden(true),
            isActive: $isActive,
            label: {
                label
            }
        )//: NavigationLink
    }

}


//MARK: CustomNavigationLink_Previews
struct CustomNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView {
            CustomNavigationLink(
                destination: Text("Destination"), isActive: .constant(true)) {
                    Text("segue")
                }
        }
    }
}
