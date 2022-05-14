//
//  TransactionListMockBuilder.swift
//  TechChallengeTests
//
//  Created by Dimitris Smyrlakis on 14/05/2022.
//

import Foundation
@testable import TechChallenge

struct TransactionListMockBuilder {
    static func makeAllFilter() -> FilterModel {
        FilterModel(title: "all", color: .black, isSelected: true)
    }
    
    static func makeFilter(_ category: TransactionModel.Category) -> FilterModel {
        FilterModel(
            title: category.rawValue,
            color: category.color,
            isSelected: true
        )
    }
}
