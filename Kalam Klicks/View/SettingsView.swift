//
//  SettingsView.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/6/25.
//

import Foundation
import SwiftUI

struct SettingsView : View {
    @ObservedObject var settings: Settings
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Capture Mode", selection: $settings.captureMode) {
                    ForEach(CaptureMode.allCases) { mode in
                        Text(mode.rawValue)
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("X") {
                        dismiss()
                    }
                    .frame(width: 30, height: 30)
                }
            }
        }
    }
}
