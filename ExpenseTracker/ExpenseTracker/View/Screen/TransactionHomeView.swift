//
//  TransactionHomeView.swift
//  ExpenseTracker
//
//  Created by Tewodros Mengesha on 13.12.2022.
//

import SwiftUI
import SwiftUICharts

struct TransactionHomeView: View {
    @EnvironmentObject var transactionListVM: TransactionListVM
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: Title

                    Text("Overview")
                        .font(.title2)
                        .bold()

                    // MARK: Chart

                    ChartView(data: transactionListVM.accumulatedTransactions())

                    // MARK: Transaction List

                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)

            }.background(Color.background)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // MARK: Notification Icon

                    ToolbarItem {
                        Image(systemName: "bell.badge")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.icon, .primary)
                    }
                }
        }.navigationViewStyle(.stack)
            .accentColor(.primary)
    }
}

struct TransactionHomeView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListVM = {
        let transactionListVM = TransactionListVM()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()

    static var previews: some View {
        TransactionHomeView()
            .environmentObject(transactionListVM)
    }
}
