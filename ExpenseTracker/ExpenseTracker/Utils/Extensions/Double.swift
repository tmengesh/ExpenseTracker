//
//  Double.swift
//  ExpenseTracker
//
//  Created by Tewodros Mengesha on 14.12.2022.
//

import Foundation

extension Double {
    func roundedTo2Digits() -> Double {
        return (self * 100).rounded() / 100
    }
}
