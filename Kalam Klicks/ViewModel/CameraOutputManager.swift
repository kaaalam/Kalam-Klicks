//
//  CameraOutputManager.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/2/25.
//

import Foundation
import AVFoundation

class CameraOutputManager : ObservableObject {
    @Published var captureModel = CaptureModel()
    var session: AVCaptureSession {
        return captureModel.getCaptureSession()
    }
    func startSession() {
        captureModel.startSession()
    }
    func stopSession() {
        captureModel.stopSession()
    }
    func takePhoto() {
        captureModel.takePhoto { image in
            if let image = image {
                print("captured photo")
            } else {
                print("could not take photo")
            }
        }
    }
}
