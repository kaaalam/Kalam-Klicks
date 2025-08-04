//
//  PhotoCaptureHandler.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/3/25.
//

import Foundation
import AVFoundation
import UIKit

class PhotoCaptureHandler : NSObject  {
    private var session: AVCaptureSession
    private let photoOutput = AVCapturePhotoOutput()
    var onPhotoCaptured: ((UIImage?) -> Void)? = { image in
        if let image = image {
            print("captured photo")
        }else {
            print("could not take photo")
        }
       
        //maybe write it out to file here?
    }
//    func takePhoto(completion: @escaping (UIImage?) -> Void)  {
//        self.onPhotoCaptured = completion
//        let photoSettings = AVCapturePhotoSettings()
//        photoOutput.capturePhoto(with: photoSettings, delegate: self)
//        
//    }
    var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            var isAuthorized = status == .authorized
            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }
            return isAuthorized
        }
    }
    init(session: AVCaptureSession) {
        self.session = session
        super.init()
        do {
            try configureCaptureSessionOutputs()
        }
        catch {
        }
    }
    private func configureCaptureSessionOutputs() throws {
        if(self.session.canAddOutput(self.photoOutput)) {
            self.session.addOutput(self.photoOutput)
        }else {
            throw CameraError.addOutputFailed
        }
    }
    
}
//MARK: Delegates
extension PhotoCaptureHandler : CaptureHandler {
    func startCapture() {
        let photoSettings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }
    
    func stopCapture() {
        
    }
    
    
}
extension PhotoCaptureHandler : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() ,let img = UIImage(data: data) else {
            onPhotoCaptured?(nil)
            return
        }
        //guard let pixelBuffer = photo.pixelBuffer else {return}
        onPhotoCaptured?(img)
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
    }
    
}
