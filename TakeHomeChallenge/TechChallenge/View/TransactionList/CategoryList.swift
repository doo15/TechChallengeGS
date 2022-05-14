//
//  CategoryList.swift
//  TechChallenge
//
//  Created by Dimitris Smyrlakis on 13/05/2022.
//

import SwiftUI

struct CategoryList: View {
    let categories: [FilterModel]
    let onSelectedItem: ((FilterModel) -> Void)?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack() {
                ForEach(categories) { item in
                    FilterView(
                        filter: item,
                        onTap: {
                            self.onSelectedItem?(item)
                        })
                }
            }
        }
        .background(Color.accentColor)
        .opacity(0.8)
    }
}

struct FilterView: View {
    let filter: FilterModel
    let onTap: (() -> Void)?
    
    var body: some View {
        Text(filter.title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(12.0)
            .background(filter.color)
            .onTapGesture {
                onTap?()
            }
            .clipShape(RoundedRectangle(cornerRadius: 24.0))
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList(categories: MockData.availableCategories, onSelectedItem: nil)
    }
}
