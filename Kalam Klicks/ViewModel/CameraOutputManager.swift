//
//  CameraOutputManager.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/2/25.
//

import Foundation
import AVFoundation

class CameraOutputManager : ObservableObject {
    @Published var captureModel : CaptureModel
    @Published var isRecording = false
    var photoHandler: PhotoCaptureHandler
    init() {
        //likewise for video etc. we want to make this configurable via settings somehow
        let captureModel = CaptureModel()
        let photoHandler = PhotoCaptureHandler(session: captureModel.getCaptureSession())
        let videoHandler = VideoCaptureHandler(session: captureModel.getCaptureSession())
        //captureModel.setHandler(handler: photoHandler)
        captureModel.setHandler(handler: videoHandler)
        self.captureModel = captureModel
        self.photoHandler = photoHandler
    }
    var session: AVCaptureSession {
        return captureModel.getCaptureSession()
    }
    func stopCapture() {
        isRecording = false
        captureModel.stopSession()
    }
    func startCapture() {
        isRecording = true
        captureModel.startCapture()
    }
}
