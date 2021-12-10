//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Rachel Yee on 12/7/21.
//
import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Candy>
    
    @State private var typeFilter = "name"
    @State private var nameFilter = ""
    @State private var sort = NSSortDescriptor(key: "name", ascending: true)
    
    var body: some View {
        VStack {
            FilteredList(filterKey: typeFilter, filterValue: nameFilter, sortValues: sort) { (item: Candy) in
                
                Text("\(item.wrappedName)")
            }
            
            Button("Add Examples") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                let candy5 = Candy(context: moc)
                candy5.name = "Ding Dang"
                candy5.origin = Country(context: moc)
                candy5.origin?.shortName = "ZH"
                candy5.origin?.fullName = "China"
                
                try? moc.save()
            }
            
            Button("Candy contains 'T'") {
                nameFilter = "T"
            }
            Button("Candy contains 'D'") {
                nameFilter = "D"
            }
            
            Button("Candy contains 'I'") {
                nameFilter = "I"
            }
            
            Button("sort Ascend") {
                sort = NSSortDescriptor(key: "name", ascending: true)
            }
            
            Button("Sort Descend") {
                sort = NSSortDescriptor(key: "name", ascending: false)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
