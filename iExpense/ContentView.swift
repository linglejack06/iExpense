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
                Section("Personal Expenses") {
                    ForEach(expenses.personalItems) { item in
                        ItemView(item: item)
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, filter: "Personal")
                    }
                }
                Section("Business Expenses") {
                    ForEach(expenses.businessItems) { item in
                        ItemView(item: item)
                    }
                    .onDelete { offsets in
                        removeItems(at: offsets, filter: "Business")
                    }
                }
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
    func removeItems(at offsets: IndexSet, filter: String) {
        let itemsToDelete: [UUID]
        if(filter == "Personal") {
            itemsToDelete = offsets.map { expenses.personalItems[$0].id }
        } else {
            itemsToDelete = offsets.map { expenses.businessItems[$0].id }
        }
        expenses.items.removeAll { item in
            itemsToDelete.contains(item.id)
        }
    }
}

struct ItemView: View {
    var item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(5)
        .border((item.amount > 100) ? .red : ((item.amount > 10) ? .yellow : .green), width: 3)
    }
}

#Preview {
    ContentView()
}
