//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Rachel Yee on 3/5/22.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    @State private var showingSortSheet = false
    enum Sorting {
    case none, descending, ascending, country
    }
    
    @State private var sorting = Sorting.none
    
    var body: some View {
        NavigationView {
                List(sortedFilteredResorts) { resort in
                    NavigationLink {
                        ResortView(resort: resort)
                    } label: {
                        HStack {
                            Image(resort.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                Text("\(resort.runs) runs")
                                    .foregroundColor(.secondary)
                            }
                            if favorites.contains(resort) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .accessibilityLabel("This is a favorite resort")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .toolbar{
                    Button {
                        showingSortSheet = true
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
                .navigationTitle("Resorts")
                .searchable(text: $searchText, prompt: "Search for a resort")
                .confirmationDialog("Sort By", isPresented: $showingSortSheet) {
                    Button("Default"){ sorting = Sorting.none
                        print(sorting)
                    }
                    Button("A - Z"){ sorting = Sorting.ascending
                        print(sorting)

                    }
                    Button("Z- A "){ sorting = Sorting.descending
                        print(sorting)

                    }
                    Button("By Country"){ sorting = Sorting.country
                        print(sorting)

                    }
                } message: {}
            
            WelcomeView()
        }
        .environmentObject(favorites)
        .phoneOnlyNavigationView()
    }
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var sortedFilteredResorts: [Resort] {
        if sorting == Sorting.ascending {
            return filteredResorts.sorted {
                $0.name < $1.name
            }
        }
        else if sorting == Sorting.descending {
            return filteredResorts.sorted {
                $1.name < $0.name
            }
        } else if sorting == Sorting.country {
            return filteredResorts.sorted {
                $0.country < $1.country
            }
        }
        else {
            return filteredResorts
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
