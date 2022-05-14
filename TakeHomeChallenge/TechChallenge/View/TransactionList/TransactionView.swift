//
//  TransactionView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

class TransactionViewModel: ObservableObject, Identifiable {
    let transaction: TransactionModel
    var isPinned: Bool
    
    init(
        transaction: TransactionModel,
        isPinned: Bool
    ) {
        self.transaction = transaction
        self.isPinned = isPinned
    }
    
    var id: String {
        return "\(transaction.id)"
    }
    
    func togglePin() {
        isPinned.toggle()
    }
}

struct TransactionView: View {
    var viewModel: TransactionViewModel
    var onPinUpdate: ((TransactionViewModel) -> Void)?

    var pinImage: some View {
        viewModel.isPinned
        ? Image(systemName: "pin.fill")
        : Image(systemName: "pin.slash.fill")
    }
    
    var transaction: TransactionModel {
        viewModel.transaction
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(transaction.category.rawValue)
                    .font(.headline)
                    .foregroundColor(transaction.category.color)
                Spacer()
                pinImage
            }
            if viewModel.isPinned {
                HStack {
                    transaction.image
                        .resizable()
                        .frame(
                            width: 60.0,
                            height: 60.0,
                            alignment: .top
                        )
                    
                    VStack(alignment: .leading) {
                        Text(transaction.name)
                            .secondary()
                        Text(transaction.accountName)
                            .tertiary()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("$\(transaction.amount.formatted())")
                            .bold()
                            .secondary()
                        Text(transaction.date.formatted)
                            .tertiary()
                    }
                }
            }
        }
        .transition(.opacity)
        .animation(.linear)
        .padding(8.0)
        .background(Color.accentColor.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
        .onTapGesture {
            viewModel.isPinned.toggle()
            onPinUpdate?(viewModel)
        }
    }
}

#if DEBUG
struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        let vm1 = TransactionViewModel(transaction: ModelData.sampleTransactions[0], isPinned: false)
        let vm2 = TransactionViewModel(transaction: ModelData.sampleTransactions[1], isPinned: false)
        VStack {
            TransactionView(viewModel: vm1)
            TransactionView(viewModel: vm2)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
