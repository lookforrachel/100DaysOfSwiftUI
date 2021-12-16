//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Rachel Yee on 12/13/21.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void )?
    var errorhandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorhandler?(error)
        } else {
            successHandler?()
        }
    }
}
