//
//  PostProcessor.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/6/25.
//

import Foundation
import AVFoundation
import Metal

class PostProcessor {
    private var computePipelineState: MTLComputePipelineState?
    private var metalDevice: MTLDevice
    private var metalLibrary: MTLLibrary?
    private var commandQueue: MTLCommandQueue?
    
    init() {
        metalDevice = MTLCreateSystemDefaultDevice()!
        metalLibrary = metalDevice.makeDefaultLibrary()!
        commandQueue = metalDevice.makeCommandQueue()!
        
    }
}
