//
//  CameraModel.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/2/25.
//

import Foundation
import AVFoundation

class CameraModel {
    private var session = AVCaptureSession()
    
    init() {
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
    //MARK: PRIVATE FUNCTIONS
    private func configureCaptureSession() throws {
        //configure the inputs
        guard let cameraDevice = AVCaptureDevice.default(for: .video) else {throw CameraError.videoDeviceNotAvailable}
        guard let depthDevice = AVCaptureDevice.default(for: .depthData) else {throw CameraError.depthDeviceNotAvailable}
        let videoInput = try AVCaptureDeviceInput(device: cameraDevice)
        let depthInput = try AVCaptureDeviceInput(device: depthDevice)
        self.session = AVCaptureSession()
        self.session.sessionPreset = .photo //might have to remove
        if(self.session.canAddInput(videoInput)) {
            self.session.addInput(videoInput)
            self.session.addInput(depthInput)
        }else {
            throw CameraError.addInputFailed 
        }
        //configure the outputs
        let photoOutput = AVCapturePhotoOutput()
        //for later: let photoSettings = AVCapturePhotoSettings()
        if(self.session.canAddOutput(photoOutput)) {
            self.session.addOutput(photoOutput)
        }else {
            throw CameraError.addOutputFailed
        }
    }
}
