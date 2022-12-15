//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Tewodros Mengesha on 13.12.2022.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionListVM = TransactionListVM()
    var body: some Scene {
        WindowGroup {
            TransactionHomeView()
                .environmentObject(transactionListVM)
        }
    }
}
