//
//  CameraModel.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/2/25.
//

import Foundation
import AVFoundation
import UIKit

class CaptureModel : NSObject {
    private var session = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    var onPhotoCaptured: ((UIImage?) -> Void)?
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
    override init() {
        super.init()
        do {
            try configureCaptureSession()
        }
        catch {
        }
    }
    //MARK: PUBLIC FUNCTIONS
    func getCaptureSession () -> AVCaptureSession {
        return self.session
    }
    func startSession() {
        if(!self.session.isRunning) {
            self.session.startRunning()
        }
    }
    func stopSession() {
        if(self.session.isRunning) {
            self.session.stopRunning()
        }
    }
    func takePhoto(completion: @escaping (UIImage?) -> Void)  {
        self.onPhotoCaptured = completion
        let photoSettings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: photoSettings, delegate: self)
        
    }
    //MARK: PRIVATE FUNCTIONS
    private func configureCaptureSession() throws {
        //configure the inputs
        guard let cameraDevice = AVCaptureDevice.default(for: .video) else {throw CameraError.videoDeviceNotAvailable}
        //guard let depthDevice = AVCaptureDevice.default(for: .depthData) else {throw CameraError.depthDeviceNotAvailable}
        let videoInput = try AVCaptureDeviceInput(device: cameraDevice)
        //let depthInput = try AVCaptureDeviceInput(device: depthDevice)
        self.session = AVCaptureSession()
        self.session.sessionPreset = .photo //might have to remove
        if(self.session.canAddInput(videoInput)) {
            self.session.addInput(videoInput)
            //self.session.addInput(depthInput)
        }else {
            throw CameraError.addInputFailed 
        }
        //configure the outputs
        if(self.session.canAddOutput(self.photoOutput)) {
            self.session.addOutput(self.photoOutput)
        }else {
            throw CameraError.addOutputFailed
        }
    }
}


//MARK: Delegates
extension CaptureModel : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() ,let img = UIImage(data: data) else {
            onPhotoCaptured?(nil)
            return
        }
        //guard let pixelBuffer = photo.pixelBuffer else {return}
        onPhotoCaptured?(img)
    }
    
}
