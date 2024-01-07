//
//  ContentView.swift
//  iExpense
//
//  Created by Jack Lingle on 1/5/24.
//

import SwiftUI
import Observation

@Observable
class User {
    var firstName = "bilbo"
    var lastName = "baggins"
}
struct ContentView: View {
    @State private var showingSheet = false
    var body: some View {
        VStack {
            Button("Show sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView()
            }
        }
    }
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

#Preview {
    ContentView()
}
