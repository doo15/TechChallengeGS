//
//  TechChallengeTests.swift
//  TechChallengeTests
//
//  Created by Adrian Tineo Cabello on 30/7/21.
//

import XCTest
@testable import TechChallenge

class FilterableTransactionListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_viewModel_canFilterTransactionBasedOnSpecificCategory() {
        // given
        let viewModel = FilterableTransactionListViewModel(transactions: MockModelData.buildWith2Categories())
        
        // when
        let filtered = viewModel.transactionsFilteredBy(category: TransactionModel.Category.entertainment)

        // then
        XCTAssertEqual(filtered.count, 1)
    }
    
    func test_viewModel_canFilterTransactionBasedOn() {
        
        // given
        let viewModel = FilterableTransactionListViewModel(
            transactions: MockModelData.buildWith2Categories()
        )
        let entertainment = TransactionListMockBuilder.makeFilter(.entertainment)
        let allCategory = TransactionListMockBuilder.makeAllFilter()
        viewModel.selectCategory(entertainment)
        
        XCTAssertEqual(viewModel.filteredTransactions.count, 1)
                
        // when
        viewModel.selectCategory(allCategory)

        // then
        XCTAssertEqual(viewModel.filteredTransactions.count, 3)
    }
}
