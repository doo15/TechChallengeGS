//
//  TechChallengeTests.swift
//  TechChallengeTests
//
//  Created by Adrian Tineo Cabello on 30/7/21.
//

import XCTest
@testable import TechChallenge

class TechChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test() {
        // given
        let viewModel = FilterableTransactionListViewModel(transactions: MockModelData.sampleTransactions)

        TransactionModel.Category.Indices.forEach({ index in
            let category = Category[index]
            let total = viewModel.totalAmountBy(category)
            print("I am \(category.rawValue) and my total is \(total)")
        })
    }
    
    func test_radianCalculator() {
        let viewModel = FilterableTransactionListViewModel(transactions: MockModelData.sampleTransactions)
        
        var ratios = [Double]
        TransactionModel.Category.Indices.forEach({ index in
            let ratio = ratio(index)
            print("my ratio is: \(ratio)")
            ratios.append(ratio)
        })
        
        let total = ratios.reduce(0,+)
        print("Total: \(total)")
    }
    
}
