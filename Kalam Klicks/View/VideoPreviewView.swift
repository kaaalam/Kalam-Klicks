//
//  VideoPreviewView.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/2/25.
//

import Foundation
import SwiftUI
import AVFoundation
struct VideoPreviewView: UIViewRepresentable {
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = UIScreen.main.bounds
        view.layer.addSublayer(previewLayer)
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {}
    
}
