//
//  CameraError.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/2/25.
//

import Foundation

enum CameraError: Error{
    case addInputFailed
    case addOutputFailed
    case videoDeviceNotAvailable
    case depthDeviceNotAvailable
}
