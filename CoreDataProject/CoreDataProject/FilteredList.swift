//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Rachel Yee on 12/7/21.
//
import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchrequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchrequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchrequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}


