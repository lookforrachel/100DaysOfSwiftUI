//
//  DetailView.swift
//  WhosWho
//
//  Created by Rachel Yee on 1/18/22.
//

import SwiftUI

struct DetailView: View {
    
    let profile: Profile
    
    var body: some View {
        Image(uiImage: UIImage(data: profile.photo!)!)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
        Text(profile.name)
        Text(profile.location)
        Text(profile.description)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(profile: Profile.example)
    }
}
