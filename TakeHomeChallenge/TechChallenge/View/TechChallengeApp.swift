//
//  TechChallengeApp.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

@main
struct TechChallengeApp: App {
    @ObservedObject var viewModel = FilterableTransactionListViewModel(transactions: ModelData.sampleTransactions)

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    TransactionListView(viewModel: viewModel)
                }
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
                
                NavigationView {
                    InsightsView(viewModel: viewModel)
                }
                .tabItem {
                    Label("Insights", systemImage: "chart.pie.fill")
                }
            }
        }
    }
}
