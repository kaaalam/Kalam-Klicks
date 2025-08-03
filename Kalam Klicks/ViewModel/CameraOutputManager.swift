//
//  CameraOutputManager.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/2/25.
//

import Foundation
import AVFoundation

class CameraOutputManager : ObservableObject {
    @Published var cameraModel = CameraModel()
    var session: AVCaptureSession {
        return cameraModel.getCaptureSession()
    }
    func startSession() {
        cameraModel.startSession()
    }
    func stopSession() {
        cameraModel.stopSession()
    }
}
