//
//  AddBookView.swift
//  Bookworm
//
//  Created by Rachel Yee on 12/3/21.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var review = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var author = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "Other"]
    
    @State private var showingEntryValidationAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id:\.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
//                    Picker("Rating", selection: $rating) {
//                        ForEach(1..<6){
//                            Text(String($0))
//                        }
//                    }
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        checkEntry()
                    }
                    .disabled(hasValidTitle == false)
                }
            }
            .navigationTitle("Add Book")
            .alert("Alert", isPresented: $showingEntryValidationAlert) {
                Button("Save"){
                    defaultValues()
                    dismiss()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Looks like some fields are empty, are you sure you want to save?")
            }
        }
    }
    
    func save() {
        let newBook = Book(context: moc)
        newBook.id = UUID()
        newBook.title = title
        newBook.review = review
        newBook.rating = Int16(rating)
        newBook.genre = genre
        newBook.author = author
        newBook.date = Date.now
        newBook.formattedDate = newBook.date?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
        
        try? moc.save()
    }
    
    func checkEntry() {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || genre.isEmpty || author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showingEntryValidationAlert = true
        } else {
            save()
            dismiss()
        }
    }
    
    func defaultValues() {
        if author.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            author = "Unknown Author"
        }
        
        if genre.isEmpty {
            genre = "Other"
        }
        
        if review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            review = "-"
        }
        
        save()
        dismiss()
    }
    
    var hasValidTitle: Bool {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
            return true
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
