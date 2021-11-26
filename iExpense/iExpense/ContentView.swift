//
//  ContentView.swift
//  iExpense
//
//  Created by Rachel Yee on 11/13/21.
//

import SwiftUI

struct ContentView: View {

    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    var myCurrency = Locale.current.currencyCode

    @State private var underTen = false
    @State private var underHundred = false
    @State private var overHundred = true
    
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text ("Personal")) {
                    ForEach(expenses.items.filter {$0.type == "Personal"}) { item in
                        HStack {
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: myCurrency ?? "USD"))
                                .foregroundColor(item.expenseStyle())
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                Section(header: Text("Business")) {
                    ForEach(expenses.items.filter {$0.type == "Business"}) { item in
                        HStack {
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: myCurrency ?? "USD"))
                                .foregroundColor(item.expenseStyle())
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpenses")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                Image (systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
