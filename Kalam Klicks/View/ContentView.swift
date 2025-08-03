//
//  ContentView.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/2/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var cameraOutputManager = CameraOutputManager()
    var body: some View {
        ZStack {
            VideoPreviewView(session: cameraOutputManager.session)
            .ignoresSafeArea()
            .onAppear() {
                cameraOutputManager.startSession()
            }
            .onDisappear() {
                cameraOutputManager.stopSession()
            }
        }
    }
}

#Preview {
    ContentView()
}
