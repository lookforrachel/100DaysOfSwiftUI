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
    
    enum predicate: String {
        case beginsWith = "BEGINSWITH"
        case contains = "CONTAINS[c]"
        
    }
    
//    predicate.beginsWith {
//        return "%K BEGINSWITH %@"
//    }
    
    init(filterKey: String, filterValue: String, sortValues: NSSortDescriptor, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchrequest = FetchRequest<T>(sortDescriptors: [sortValues], predicate: NSPredicate(format: "%K \(predicate.contains) %@", filterKey, filterValue))
        
        

        
        self.content = content
    }
}


