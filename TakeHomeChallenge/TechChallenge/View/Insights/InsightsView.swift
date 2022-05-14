//
//  InsightsView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

struct InsightsView: View {
    @ObservedObject var viewModel: FilterableTransactionListViewModel
    
    var body: some View {
        List {
            RingView(viewModel: viewModel)
                .scaledToFit()
            ForEach(TransactionModel.Category.allCases) { category in
                HStack {
                    Text(category.rawValue)
                        .font(.headline)
                        .foregroundColor(category.color)
                    
                    Spacer()
                    
                    Text(viewModel.totalAmountBy(category))
                        .bold()
                        .secondary()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Insights")
    }
}

#if DEBUG
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FilterableTransactionListViewModel(transactions: ModelData.sampleTransactions)
        InsightsView(viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
#endif
