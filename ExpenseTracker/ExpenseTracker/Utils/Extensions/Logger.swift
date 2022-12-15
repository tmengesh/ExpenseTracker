//
//  Logger.swift
//  ExpenseTracker
//
//  Created by Tewodros Mengesha on 15.12.2022.
//

import Foundation
import os

extension Logger {
    static func createLogger(file: String = #file) -> Logger {
        let fileString = NSString(string: file)
        return Logger(subsystem: Bundle.main.bundleIdentifier!, category: "ExpenseTracker-\(fileString.lastPathComponent.split(separator: ".").first!)")
    }

    func pretty_function(function: String = #function, line: Int = #line) {
        self.debug("\(function)")
    }
}
