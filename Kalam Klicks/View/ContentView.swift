//
//  ContentView.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/2/25.
//

import SwiftUI
import Photos
struct ContentView: View {
    @EnvironmentObject var cameraOutputManager: CameraOutputManager
    @EnvironmentObject var settings : Settings

    @State var isShowingSettings = false
    var body: some View {
        VStack {
            VideoPreviewView(session: cameraOutputManager.session)
            .ignoresSafeArea()
            .onAppear() {
                
            }
            .onDisappear() {
                
            }
            Spacer()
            HStack {
                Button(action: {
                    isShowingSettings = true
                }) {
                    Image(systemName:"gear")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.gray)
                }
                .onChange(of: settings.captureMode) { newMode in
                    cameraOutputManager.changeCaptureType()
                }
                .sheet(isPresented: $isShowingSettings) {
                    SettingsView(settings: settings)
                }
                Spacer()
                Button(action: {
                    switch settings.captureMode {
                    case CaptureMode.photo.rawValue:
                        cameraOutputManager.startCapture()
                    case CaptureMode.video.rawValue:
                        cameraOutputManager.isRecording ? cameraOutputManager.stopCapture() : cameraOutputManager.startCapture()
                    default:
                        cameraOutputManager.startCapture()
                    }

                }) {
                    Image(systemName: cameraOutputManager.isRecording ? "camera.circle.fill" : "camera.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                
                    .foregroundColor(cameraOutputManager.isRecording ? .red : .green)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
