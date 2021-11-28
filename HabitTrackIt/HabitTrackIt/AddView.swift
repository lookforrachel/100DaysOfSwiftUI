//
//  AddView.swift
//  HabitTrackIt
//
//  Created by Rachel Yee on 11/26/21.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var habits: Habits
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Good"
    @State private var description = ""
    @State private var amount = 0
    @State private var count = 0
    
    let types = ["Build", "Break"]
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                         Text($0)
                    }
                }
                
                TextField("Description", text: $description)
                TextField("Amount", value: $amount, format: .number)
            }
            .navigationTitle("Add a habit")
            .toolbar {
                Button ("save"){
                    let item = HabitItem(name: name, type: type, description: description, amount: amount, count: count)
                    habits.items.append(item)
                    dismiss()
            }
        }
    }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
