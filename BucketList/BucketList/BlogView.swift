//
//  BlogView.swift
//  BucketList
//
//  Created by Rachel Yee on 12/22/21.
//

import SwiftUI

struct BlogView: View {
    
    var blog: [Post] = FileManager.default.decode("blog.txt")

    
    var body: some View {
        List {
            ForEach(blog, id: \.self) { post in
            Text(post.title)
            }
        }
    }
}

struct BlogView_Previews: PreviewProvider {
    static var previews: some View {
        BlogView()
    }
}
