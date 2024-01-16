//
//  ContentView.swift
//  iExpense
//
//  Created by Jack Lingle on 1/5/24.
//

import SwiftUI
import Observation

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddView = true
                }
            }
        }
        .sheet(isPresented: $showingAddView) {
            AddView(expenses: expenses)
        }
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
