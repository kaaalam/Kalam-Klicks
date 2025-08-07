//
//  CameraOutputManager.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/2/25.
//

import Foundation
import AVFoundation
import SwiftUI
import Combine
class CameraOutputManager : ObservableObject {
    let settings : Settings
    private var cancellables = Set<AnyCancellable>()
    @Published var captureModel : CaptureModel
    @Published var isRecording = false
    var photoHandler: PhotoCaptureHandler
    var videoHandler: VideoCaptureHandler
    init(settings: Settings) {
        //likewise for video etc. we want to make this configurable via settings somehow
        self.settings = settings
        let captureModel = CaptureModel()
        let photoHandler = PhotoCaptureHandler(session: captureModel.getCaptureSession())
        let videoHandler = VideoCaptureHandler(session: captureModel.getCaptureSession())
        captureModel.setHandler(handler: photoHandler)
        //captureModel.setHandler(handler: videoHandler)
        self.captureModel = captureModel
        self.photoHandler = photoHandler
        self.videoHandler = videoHandler
        
    }
    var session: AVCaptureSession {
        return captureModel.getCaptureSession()
    }
    func changeCaptureType() {
        print("Changed capture type to \(settings.captureMode)")
        switch settings.captureMode {
        case CaptureMode.photo.rawValue:
            captureModel.setHandler(handler: photoHandler)
        case CaptureMode.video.rawValue:
            captureModel.setHandler(handler: videoHandler)
        default:
            captureModel.setHandler(handler: photoHandler)
        }
    }
    func stopCapture() {
        isRecording = false
        captureModel.stopCapture()
    }
    func startCapture() {
        if(settings.captureMode == CaptureMode.photo.rawValue) {
            captureModel.startCapture()
            
        }else if(settings.captureMode == CaptureMode.video.rawValue) {
            isRecording = true
            captureModel.startCapture()
        }

    }
}
