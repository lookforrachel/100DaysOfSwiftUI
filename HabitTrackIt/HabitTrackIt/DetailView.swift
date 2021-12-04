//
//  DetailView.swift
//  HabitTrackIt
//
//  Created by Rachel Yee on 11/27/21.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var habits: Habits
    let item: HabitItem
    var index: Int
    
    var body: some View {
        VStack(alignment:.leading){
            Text(item.name)
                .font(.headline)
            Text(item.description)
            
            HStack{
                Button(action: reset, label: {
                    Image(systemName: "arrow.counterclockwise")
                })
                Text("\(item.count) / \(item.amount)")
            }
        }
    }
    
    func reset() {
        habits.items[index].count = 0
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(habits: Habits(), item: HabitItem(name: "", type: "", description: "", amount: 0, count: 0), index: 0)
    }
}
