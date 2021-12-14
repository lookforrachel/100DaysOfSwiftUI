//
//  ContentView.swift
//  Instafilter
//
//  Created by Rachel Yee on 12/12/21.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterAmount = 0.0
    
    var body: some View {
        VStack {
            Image("Chickens")
        }
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
//                Slider(value: $filterAmount, in: 0...10)
            }
            .onAppear(perform: loadImage)
        }
    func loadImage() {
        guard let inputImage = UIImage(named: "Chickens") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.crystallize()
        currentFilter.inputImage = beginImage
        
        let amount = 15.0
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputRadiusKey)
        }
        
//        currentFilter.center = CGPoint(x: inputImage.size.width/2, y: inputImage.size.height/2)
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
