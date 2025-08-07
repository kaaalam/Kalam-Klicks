//
//  Kalam_KlicksApp.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/2/25.
//

import SwiftUI

@main
struct Kalam_KlicksApp: App {
 
    @StateObject private var settings = Settings()
    @StateObject private var cameraManager: CameraOutputManager
    init() {
        let settings = Settings()
        _settings = StateObject(wrappedValue: settings)
        _cameraManager = StateObject(wrappedValue: CameraOutputManager(settings: settings))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
                .environmentObject(cameraManager)
        }
    }
}
