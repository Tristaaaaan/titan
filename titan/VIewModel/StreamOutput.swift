//
//  StreamOutput.swift
//  titan
//
//  Created by Tristan on 8/20/26.
//

import SwiftUI
import ScreenCaptureKit

class StreamOutput: NSObject, SCStreamOutput, SCStreamDelegate, SCRecordingOutputDelegate {
    var finishedRecording: (() -> Void)?
    func stream(_ stream: SCStream, didStopWithError error: any Error) {
        finishedRecording?()
    }
    
    func recordingOutput(_ recordingOutput: SCRecordingOutput, didFailWithError error: any Error) {
        finishedRecording?()

    }
    
    func recordingOutputDidFinishRecording(_ recordingOutput: SCRecordingOutput) {
        finishedRecording?()

    }
}
