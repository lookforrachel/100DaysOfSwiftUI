//
//  CardView.swift
//  Flashzilla
//
//  Created by Rachel Yee on 2/1/22.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    @State private var isShowingAnswer = false
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25,style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .onTapGesture {
            isShowingAnswer.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
