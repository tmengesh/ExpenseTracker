//
//  TransactionsListView.swift
//  ExpenseTracker
//
//  Created by Tewodros Mengesha on 13.12.2022.
//

import SwiftUI

struct TransactionsListView: View {
    @EnvironmentObject var transactionListVM: TransactionListVM
    var body: some View {
        VStack {
            List {
                // MARK: Transaction Groups

                ForEach(Array(transactionListVM.groupTransactionByMonth()), id: \.key) { month, transactions in
                    Section {
                        // MARK: Transaction List

                        ForEach(transactions) { transaction in
                            TransactionRow(transation: transaction)
                        }
                    } header: {
                        // MARK: Transaction Month

                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionsListView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListVM = {
        let transactionListVM = TransactionListVM()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()

    static var previews: some View {
        NavigationView {
            TransactionsListView()
        }
        .environmentObject(transactionListVM)
    }
}
