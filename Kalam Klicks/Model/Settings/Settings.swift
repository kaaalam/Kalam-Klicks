//
//  Settings.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/6/25.
//

import Foundation
import SwiftUI

class Settings : ObservableObject {
    @AppStorage("Capture Mode") var captureMode = CaptureMode.photo.rawValue
}




enum CaptureMode: String, CaseIterable, Identifiable{
    case photo = "Photo"
    case video = "Video"
    var id: String  {rawValue}
}
