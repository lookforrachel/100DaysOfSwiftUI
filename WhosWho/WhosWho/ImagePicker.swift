//
//  ImagePicker.swift
//  WhosWho
//
//  Created by Rachel Yee on 1/10/22.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: UIImage?
        
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                self.parent.image = image as? UIImage
                }
            }
        }
    }
    
//    typealias UIViewControllerType = PHPickerViewController

    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        //create a new picker
        var config = PHPickerConfiguration()
        
        //The picker should just give us images
        config.filter = .images
        
        //Put the images into a view controller
        let picker = PHPickerViewController(configuration: config)
        
        //Use the Coordinator class as the delegate for our PHPickerViewController (report any user interaction (i.e. pressing cancel, selecting an image) to our coordinator)
        picker.delegate = context.coordinator
                
        // and send it back
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
