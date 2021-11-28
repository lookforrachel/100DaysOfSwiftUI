//
//  ContentView.swift
//  HabitTrackIt
//
//  Created by Rachel Yee on 11/26/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Build")){
                    ForEach (habits.items.filter {$0.type == "Build"}) { item in
                        NavigationLink {
                            if let index = habits.items.firstIndex(of: item){
                                DetailView(habits: habits, item: item, index: index)
                            }
                        } label: {
                            HStack {
                                VStack(alignment:.leading){
                                    Text(item.name)
                                        .font(.headline)
                                }
                                
                                Spacer()
                                VStack{
                                    Button("\(item.count) / \(item.amount)"){
                                    }
                                }
                                .onTapGesture {
                                    var counter = item.count
                                    counter += 1
                                    if let index = habits.items.firstIndex(of: item) {
                                    habits.items[index].count = counter
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section(header: Text("Break")) {
                    ForEach (habits.items.filter {$0.type == "Break"}) { item in
                        NavigationLink {
                            if let index = habits.items.firstIndex(of: item){
                                DetailView(habits: habits, item: item, index: index)
                            }
                        } label: {
                            HStack {
                                VStack(alignment:.leading){
                                    Text(item.name)
                                        .font(.headline)
                                }
                                
                                Spacer()
                                VStack{
                                    Button("\(item.count) / \(item.amount)"){
                                    }
                                    .foregroundColor(item.count > item.amount ? .red : .blue)
                                }
                                .onTapGesture {
                                    var counter = item.count
                                    counter += 1
                                    if let index = habits.items.firstIndex(of: item) {
                                    habits.items[index].count = counter
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("Habits")
            .toolbar{
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddHabit) { AddView(habits: habits)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
