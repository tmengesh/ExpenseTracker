//
//  TransactionListVM.swift
//  ExpenseTracker
//
//  Created by Tewodros Mengesha on 13.12.2022.
//

import Collections
import Combine
import Foundation
import os

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListVM: ObservableObject {
    @Published var transactions: [Transaction] = []

    private var cancellables = Set<AnyCancellable>()
    private let logger = Logger.createLogger()

    init() {
        getTransactionsFromURL()
        // getTransactionsFromBundle()
    }

    func getTransactionsFromURL() {
        logger.pretty_function()
        guard let url = URL(string: "https://api.npoint.io/29387d7dd433c2735d40")

        else {
            logger.debug("Invalid URL")

            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }

                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [self] completion in
                switch completion {
                case .failure(let error):
                    logger.debug("Error fetching transations from URL: \(error.localizedDescription)")
                case .finished:
                    logger.info("Finished fetching transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
            }
            .store(in: &cancellables)
    }

    func getTransactionsFromBundle() {
        logger.pretty_function()
        if let fileLocation = Bundle.main.url(forResource: "transactions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJSON = try jsonDecoder.decode([Transaction].self, from: data)
                transactions = dataFromJSON
            } catch {
                logger.debug("Error fetching transations from bundle: \(error.localizedDescription)")
            }
        }
    }

    func groupTransactionByMonth() -> TransactionGroup {
        logger.pretty_function()
        guard !transactions.isEmpty else { return [:] }

        let groupTransactions = TransactionGroup(grouping: transactions) { $0.month }

        return groupTransactions
    }

    func accumulatedTransactions() -> TransactionPrefixSum {
        logger.pretty_function()
        guard !transactions.isEmpty else { return [] }

        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        logger.info("dateInterval")

        var sum: Double = .zero
        var cummulativeSum = TransactionPrefixSum()

        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }

            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cummulativeSum.append((date.formatted(), sum))
        }
        return cummulativeSum
    }
}
