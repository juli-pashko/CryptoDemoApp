//
//  SearchBarView.swift
//  CryptoDemoApp
//
//  Created by Yulia Pashko on 19.11.2022.
//

import SwiftUI

struct SearchBarView: View {
    
    //MARK: - Properties
    @Binding var searchText: String
    
    
    //MARK: - Body
    var body: some View {
        HStack {
            searchIcone
            searchTextField
        }//: HStack
        .font(.headline)
        .frame(height: 44)
        .background(
            backgroundView
        )
    }

}


//MARK: - SearchBarView_Previews
struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
        
        SearchBarView(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}


//MARK: - SearchBarView Extension
extension SearchBarView {
    
    //MARK: - Views
    private var searchIcone: some View {
        Image(systemName: Icon.magnifyingglass)
            .foregroundColor(
                searchText.isEmpty ?
                Color.theme.secondaryText : Color.theme.accent
            )
            .padding(.horizontal, 8)
    }
    
    private var searchTextField: some View {
        TextField("Search", text: $searchText)
            .foregroundColor(Color.theme.accent)
            .disableAutocorrection(true)
            .overlay(
                Image(systemName: Icon.xmarkCircleFill)
                .padding()
                .offset(x: 10)
                .foregroundColor(Color.theme.accent)
                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                    searchText = ""
                }
             ,alignment: .trailing)
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.theme.background)
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
    }
    
}
