//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Jack Lingle on 1/16/24.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let name: String
    let type: String
    let amount: Double
    var id = UUID()
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    var businessItems: [ExpenseItem] {
        items.filter { $0.type == "Business" }
    }
    var personalItems: [ExpenseItem] {
        items.filter { $0.type == "Personal" }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
