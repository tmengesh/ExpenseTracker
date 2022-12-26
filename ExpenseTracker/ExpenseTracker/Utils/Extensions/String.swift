//
//  String.swift
//  ExpenseTracker
//
//  Created by Tewodros Mengesha on 13.12.2022.
//

import Foundation
import SwiftUI

extension String {
    func dateParsed() -> Date {
        guard let parsedDate = DateFormatter.allNumericFI.date(from: self) else { return Date() }

        return parsedDate
    }
}
