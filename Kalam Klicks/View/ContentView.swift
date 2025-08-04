//
//  ContentView.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/2/25.
//

import SwiftUI
import Photos
struct ContentView: View {
    @StateObject private var cameraOutputManager = CameraOutputManager()
    var body: some View {
        ZStack {
            VideoPreviewView(session: cameraOutputManager.session)
            .ignoresSafeArea()
            .onAppear() {
                
            }
            .onDisappear() {
                
            }
            Button(action: {
                cameraOutputManager.isRecording ? cameraOutputManager.stopCapture() : cameraOutputManager.startCapture()
            }) {
                Image(systemName: cameraOutputManager.isRecording ? "camera.circle.fill" : "camera.circle")
                .frame(width: 60, height: 60)
                .foregroundColor(cameraOutputManager.isRecording ? .red : .green)
            }
        }
    }
}

#Preview {
    ContentView()
}
