//
//  VideoCaptureHandler.swift
//  Kalam Klicks
//
//  Created by Kalam on 8/3/25.
//

import Foundation
import AVFoundation
import Photos

class VideoCaptureHandler : NSObject {
    private var session: AVCaptureSession
    private let videoOutput = AVCaptureVideoDataOutput()
    private var assetWriter: AVAssetWriter?
    private var assetWriterInput: AVAssetWriterInput?
    private let captureQueue = DispatchQueue(label: "VideoCaptureHandler Queue")
    var isRecording = false
    var isWriting = false
    var frameCounter = 0 //remove later
    init(session: AVCaptureSession) {
        self.session = session
        super.init()
        do {
            try configureCaptureSessionOutputs()
            try setupAssetWriter()
        } catch {
            
        }
    }
    private func configureCaptureSessionOutputs() throws {
        self.videoOutput.setSampleBufferDelegate(self, queue: captureQueue)
        self.videoOutput.alwaysDiscardsLateVideoFrames = true
        if self.session.canAddOutput(self.videoOutput) {
            self.session.addOutput(self.videoOutput)
        } else {
            throw CameraError.addOutputFailed
        }
    }
    private func setupAssetWriter() throws {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM_dd_yyyy_HH_mm_ss"
        let formattedDate = dateFormatter.string(from: currentDate)
        let outputFileString = "KalKlicks_"+formattedDate+".mp4"
        let outputURL = documentsDirectory[0].appendingPathComponent(outputFileString)
        print(outputURL)
        self.assetWriter = try AVAssetWriter(outputURL: outputURL, fileType: .mp4)
        let videoSettings = self.videoOutput.recommendedVideoSettingsForAssetWriter(writingTo: .mp4) //no need to use recommended settings necessarily
        self.assetWriterInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
        guard let assetWriter = self.assetWriter, let assetWriterInput = self.assetWriterInput, assetWriter.canAdd(assetWriterInput) else {
            print("could not add asset writer input")
            return
        }
        assetWriter.add(assetWriterInput)
        assetWriter.startWriting()
    }
}
//MARK: Extensions
extension VideoCaptureHandler : CaptureHandler {
    func startCapture() {
        self.isRecording = true
    }
    
    func stopCapture() {
        self.isRecording = false
        self.assetWriterInput?.markAsFinished()
        self.assetWriter?.finishWriting {
        let url = self.assetWriter?.outputURL
        PHPhotoLibrary.shared().performChanges({
                       PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url!)
           }) { success, error in
               if success {
                   print("Saved to Photos: \(url!.lastPathComponent)")
                   do {
                       self.isWriting = false
                       try self.setupAssetWriter()
                   }catch { print("Error setting up asset writer: \(error)")}
               } else {
                   print(" Save failed: \(error?.localizedDescription ?? "Unknown error")")
               }
           }
        }
    }
    
    
}
extension VideoCaptureHandler : AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if(self.isRecording) {
            guard let assetWriterInput = self.assetWriterInput else {
                print("writer input not setup correctly")
                return
            }
            let timeStamp = CMSampleBufferGetPresentationTimeStamp(sampleBuffer)
            if(!isWriting) {
                self.assetWriter?.startSession(atSourceTime: timeStamp)
                isWriting = true
            }
            else {
                if assetWriterInput.isReadyForMoreMediaData {
                    //print("writing out sample buffer to asset writer")
                    assetWriterInput.append(sampleBuffer)
                }
            }
        }
    }
}
