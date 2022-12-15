//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Tewodros Mengesha on 13.12.2022.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "12/21/2022", institution: "Burger King", account: "Burger king iso omena", merchant: "Restis", amount: 10.80, type: "debit", categoryId: 801, category: "Food & Beverage", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
