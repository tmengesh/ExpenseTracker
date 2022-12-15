//
//  DateFormatter.swift
//  ExpenseTracker
//
//  Created by Tewodros Mengesha on 13.12.2022.
//

import Foundation
import os
import SwiftUI

extension DateFormatter {
    
    static let allNumericFI: DateFormatter = {
        let logger = Logger.createLogger()

        logger.debug("Initializing DateFormatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        logger.debug("Formatter: \(formatter)")

        return formatter
    }()
}

extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}
