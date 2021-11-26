//
//  ContentListView.swift
//  Moonshot
//
//  Created by Rachel Yee on 11/20/21.
//

import SwiftUI

struct ContentListView: View {
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    
    @State private var gridView = false
    
    var body: some View {
            List {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    }
                label: {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(10)
                            
                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }
                    }
                    .listRowBackground(Color.darkBackground)

                }
            }
            .listStyle(.plain)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        
        
    }
}

struct ContentListView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        ContentListView(astronauts: astronauts , missions: missions)
    }
}
