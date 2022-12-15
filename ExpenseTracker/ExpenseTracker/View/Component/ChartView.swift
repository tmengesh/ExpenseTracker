//
//  ChartView.swift
//  ExpenseTracker
//
//  Created by Tewodros Mengesha on 14.12.2022.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    var data: TransactionPrefixSum
    var body: some View {
        if !data.isEmpty {
            let totalExpenses = data.last?.1 ?? 0
            CardView {
                VStack(alignment: .leading) {
                    ChartLabel(totalExpenses.formatted(.currency(code: "EUR")), type: .title, format: "%.02f€ ")
                    LineChart()
                }.background(Color.systemBackground)
            }
            .data(data)
            .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
            .frame(height: 300)
        }
    }
}
