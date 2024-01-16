//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Jack Lingle on 1/16/24.
//

import Foundation

struct ExpenseItem {
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]()
}
