//
//  DeviceRotationUtil.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/6/25.
//

import Foundation
import UIKit

func getVideoTransform() -> CGAffineTransform {
    switch UIDevice.current.orientation {
    case .portrait:
        return CGAffineTransform(rotationAngle: .pi/2)
    case .portraitUpsideDown:
        return CGAffineTransform(rotationAngle: -.pi/2)
    case .landscapeLeft:
        return CGAffineTransform.identity
    case .landscapeRight:
        return CGAffineTransform(rotationAngle: .pi)
    default:
        return CGAffineTransform(rotationAngle: .pi/2)
    }
}

func getVideoRotationAngle() -> CGFloat {
    switch UIDevice.current.orientation {
    //Home button on bottom
    case .portrait:
        return 90
    //Home button on top
    case .portraitUpsideDown:
        return 270
    //Home button on right
    case .landscapeLeft:
        return 0
    //Home button on left
    case .landscapeRight:
        return 180

    default:
        return 90
    }

}
