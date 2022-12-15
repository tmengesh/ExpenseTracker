//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Tewodros Mengesha on 13.12.2022.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var transation: Transaction

    var body: some View {
        HStack(spacing: 20) {
            // MARK: Transaction Category Icon

            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: transation.icon), fontsize: 24, color: Color.icon)
                }
            VStack(alignment: .leading, spacing: 6) {
                // MARK: Transaction Merchant

                Text(transation.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)

                // MARK: Transaction Category

                Text(transation.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)

                // MARK: Transaction Date

                Text(transation.dateParsed, format: .dateTime.day().month().year())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }

            Spacer()

            // MARK: Transaction Amount

            Text(transation.signedAmount, format: .currency(code: "EUR"))
                .bold()
                .foregroundColor(transation.type == TransactionType.credit.rawValue ? Color.text : .primary)
        }
        .padding([.top, .bottom], 8)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(transation: transactionPreviewData)
    }
}
