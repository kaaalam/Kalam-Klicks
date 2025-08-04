//
//  CameraModel.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/2/25.
//

import Foundation
import AVFoundation

class CaptureModel : NSObject {
    private var session = AVCaptureSession()
    private var captureHandler : (any CaptureHandler)?
    private let captureQueue = DispatchQueue(label: "Camera CaptureSession Queue")
    
    override init() {
        super.init()
        do {
            try configureCaptureSessionInputs()
        }
        catch {
        }
        
    }
    //MARK: PRIVATE FUNCTIONS
    private func configureCaptureSessionInputs() throws {
        guard let cameraDevice = AVCaptureDevice.default(for: .video) else {throw CameraError.videoDeviceNotAvailable}
        //guard let depthDevice = AVCaptureDevice.default(for: .depthData) else {throw CameraError.depthDeviceNotAvailable}
        let videoInput = try AVCaptureDeviceInput(device: cameraDevice)
        //let depthInput = try AVCaptureDeviceInput(device: depthDevice)
        self.session = AVCaptureSession()
        //self.session.sessionPreset = .photo //might have to remove
        if(self.session.canAddInput(videoInput)) {
            self.session.addInput(videoInput)
        }else {
            throw CameraError.addInputFailed
        }
        self.session.commitConfiguration()
        captureQueue.async {
            self.session.startRunning()
        }
    }
    //MARK: PUBLIC FUNCTIONS
    func getCaptureSession () -> AVCaptureSession {
        return self.session
    }
    func startCapture() {
        captureHandler?.startCapture()
    }
    func stopSession() {
        captureHandler?.stopCapture()
    }
    func setHandler(handler: any CaptureHandler) {
        self.captureHandler = handler
    }
    //MARK: PRIVATE FUNCTIONS

}



