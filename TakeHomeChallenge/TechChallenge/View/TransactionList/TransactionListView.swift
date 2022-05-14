//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

class FilterableTransactionListViewModel: ObservableObject {
    
    let transactionViewModels: [TransactionViewModel]
    @Published var pinnedTransactions: [TransactionViewModel]
    @Published var filteredTransactions: [TransactionViewModel]
    
    let categories = MockData.availableCategories
    @Published var selectedCategory: FilterModel = .all
    
    init(transactions: [TransactionModel] = ModelData.sampleTransactions) {
        self.transactionViewModels = transactions.map({ item in
            TransactionViewModel(
                transaction: item,
                isPinned: true
            )
        })
        self.pinnedTransactions = transactionViewModels.filter({ $0.isPinned })
        self.filteredTransactions = self.transactionViewModels
    }
    
    // MARK: - Functions
    
    func selectCategory(_ category: FilterModel) {
        selectedCategory = category
        filteredTransactions = transactionsFilteredBy(category)
    }
    
    func togglePinStatus(viewModel: TransactionViewModel) {
        pinnedTransactions = transactionViewModels.filter({ $0.isPinned })
    }
    
    func transactionsFilteredBy(_ category: FilterModel) -> [TransactionViewModel] {
        guard category.title != "all" else {
            return transactionViewModels
        }
        return transactionViewModels.filter({ $0.transaction.belongsTo(category) })
    }
    
    func transactionsFilteredBy(category: TransactionModel.Category) -> [TransactionViewModel] {
        transactionsFilteredBy(categoryName: category.rawValue)
    }
    
    func transactionsFilteredBy(categoryName: String) -> [TransactionViewModel] {
        guard categoryName != "all" else {
            return transactionViewModels
        }
        return transactionViewModels.filter(
            { $0.transaction.category.rawValue == categoryName }
        )
    }
    
    var amount: String {
        totalAmountForCategory(selectedCategory)
    }
    
    func totalAmountForCategory(_ category: FilterModel) -> String {
        let transactions = transactionsFilteredBy(category)
        let total = calculateTotalOfPinnedTransactions(transactions)
        return "$\(total.formatted())"
    }
    
    func totalAmountBy(_ category: TransactionModel.Category, includeCurrency: Bool = true) -> String {
        let transactions = transactionsFilteredBy(categoryName: category.rawValue)
        let total = calculateTotalOfPinnedTransactions(transactions)
        return includeCurrency ? "$\(total.formatted())" : "\(total.formatted())"
    }
    
    func totalAmountOfAllPinnedItems(includeCurrency: Bool = true) -> String {
        let total = calculateTotalOfPinnedTransactions(transactionViewModels)
        return includeCurrency ? "$\(total.formatted())" : "\(total.formatted())"
    }
    
    private func calculateTotalOfPinnedTransactions(_ transactions: [TransactionViewModel]) -> Double {
        let total = transactions
            .filter({ $0.isPinned})
            .reduce(0, { previousTotal, item in
                return item.transaction.amount + previousTotal
            })
        return total
    }
}

struct TransactionListView: View {
    @ObservedObject var viewModel: FilterableTransactionListViewModel
                
    var body: some View {
        VStack {
            CategoryList(
                categories: viewModel.categories,
                onSelectedItem: { selected in
                    viewModel.selectCategory(selected)
                }
            )
            .frame(maxWidth: .infinity, maxHeight: 80.0, alignment: .center)
                
            List {
                ForEach(viewModel.filteredTransactions) { viewModel in
                    TransactionView(
                        viewModel: viewModel,
                        onPinUpdate: { item in
                            self.viewModel.togglePinStatus(viewModel: item)
                        })
                }
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())
            
            TotalsView(
                title: viewModel.selectedCategory.title,
                titleColor: viewModel.selectedCategory.color,
                totalAmount: viewModel.amount
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Transactions")
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(viewModel: FilterableTransactionListViewModel(transactions: ModelData.sampleTransactions))
    }
}
#endif
