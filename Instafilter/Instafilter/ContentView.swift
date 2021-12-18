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
    @State private var filterIntensity = 1.0
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var hasImageToSave = false
    
    @State private var intensityKey = false
    @State private var filterRadius = 1.0
    @State private var radiusKey = false
    @State private var filterScale = 1.0
    @State private var scaleKey = false
    @State private var filterAngle = 1.0
    @State private var angleKey = false
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }

                VStack {
                    if intensityKey {
                        HStack {
                            Text("Intensity")
                            Slider(value: $filterIntensity)
                                .onChange(of: filterIntensity) { _ in applyProcessing() }
                        }
                        .padding(.vertical)

                    }
                    if radiusKey {
                        HStack {
                            Text("Radius")
                            Slider(value: $filterRadius)
                                .onChange(of: filterRadius) { _ in applyProcessing() }
                        }
                        .padding(.vertical)
                    }
                    if scaleKey {
                        HStack {
                            Text("Scale")
                            Slider(value: $filterScale)
                                .onChange(of: filterScale) { _ in applyProcessing() }
                        }
                        .padding(.vertical)
                    }
                    if angleKey {
                        HStack {
                            Text("Angle")
                            Slider(value: $filterAngle)
                                .onChange(of: filterAngle) { _ in applyProcessing() }
                        }
                        .padding(.vertical)
                    }
                }
                
                HStack {
                    Button("Change filter"){
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled(image == nil)

                }

            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a Filter", isPresented: $showingFilterSheet) {
                Section{
                    Button("Crystallize"){ setFilter(CIFilter.crystallize()) }
                    Button("Edges"){ setFilter(CIFilter.edges()) }
                    Button("Gaussian Blur"){ setFilter(CIFilter.gaussianBlur()) }
                    Button("Pixellate"){ setFilter(CIFilter.pixellate()) }
                    Button("Sepia Tone"){ setFilter(CIFilter.sepiaTone()) }
                }
                Button("Unsharp Mask"){ setFilter(CIFilter.unsharpMask()) }
                Button("Vignette"){ setFilter(CIFilter.vignette()) }
                Button("Kaleidoscope"){ setFilter(CIFilter.kaleidoscope()) }
                Button("Pointilize"){ setFilter(CIFilter.pointillize()) }
                Button("Gloom"){ setFilter(CIFilter.gloom()) }
                Button("Cancel", role: .cancel){ }
            } message: {
                Text("")
            }
        }
        }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        hasImageToSave = true
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            intensityKey = true
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            radiusKey = true
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            scaleKey = true
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
        }
        
        if inputKeys.contains(kCIInputAngleKey) {
            angleKey = true
            currentFilter.setValue(filterAngle, forKey: kCIInputAngleKey)
        }
                
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        
        intensityKey = false
        radiusKey = false
        scaleKey = false
        angleKey = false
        
        currentFilter = filter
        loadImage()
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorhandler = {
            print("Oops! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
