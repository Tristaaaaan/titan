//
//  ScreenRecorder.swift
//  titan
//
//  Created by Tristan on 8/20/26.
//

import SwiftUI
import ScreenCaptureKit
import Combine
import AppKit
@MainActor
class ScreenRecorder: NSObject, ObservableObject, @preconcurrency SCContentSharingPickerObserver {
    override init () {
        super.init()
    }
    
    @Published var showCursor: Bool = true
    @Published var captureAudio: Bool = true
    @Published var backgroundColor: Color = .white
    @Published var videoScale: VideoScale = .normal
    @Published var isRecording: Bool = false
    
    /// properties
    private var contentFilter: SCContentFilter?
    private var stream: SCStream?
    private var streamOutput = StreamOutput()
    
    /// setting stream up
    private func setupAndRecordWindow (url: URL) async throws {
        guard let contentFilter else { return }
        
        let configuration = SCStreamConfiguration()
        configuration.showsCursor = showCursor
        configuration.capturesAudio = captureAudio
        configuration.backgroundColor = backgroundColor == .white ? .white : NSColor(backgroundColor).cgColor
        
        let scale = CGFloat(videoScale.rawValue)
        let scaledVideoSize = contentFilter.contentRect.size.applying(.init(scaleX: scale, y: scale))
        
        configuration.width = Int(scaledVideoSize.width)
        configuration.height = Int(scaledVideoSize.height)
        
        configuration.scalesToFit = true
        let stream = SCStream(filter: contentFilter, configuration: configuration, delegate: streamOutput)
        
        try stream.addStreamOutput(streamOutput, type: .audio, sampleHandlerQueue: nil)
        try stream.addStreamOutput(streamOutput, type: .screen, sampleHandlerQueue: nil)
        
        /// file saving
        let outputConfiguration = SCRecordingOutputConfiguration()
        
        outputConfiguration.outputURL = url
        outputConfiguration.outputFileType = .mov
        
        let output = SCRecordingOutput(configuration: outputConfiguration, delegate: streamOutput)
        
        try stream.addRecordingOutput(output)
        try await stream.startCapture()
        
        self.isRecording = true
        self.stream = stream
        
        streamOutput.finishedRecording = {
            Task { @MainActor in
                self.stream = nil
                self.contentFilter = nil
                self.isRecording = false
            }
        }
        
    }
    
    func stopWindowRecording() {
        Task {

            do {
                try await stream?.stopCapture()
            } catch {
                
                print(error.localizedDescription)
            }
        }
    }
    /// ask file loc
    private func askFileLocation() {
        Task {
            do {
                print("Showing file location")
                let panel =  NSOpenPanel()
                panel.canChooseFiles = false
                panel.canChooseDirectories = true
                panel.allowsMultipleSelection = false
                panel.showsHiddenFiles = false
                
                let response  = panel.runModal()
                if response == .OK {
                    
       
                    if let fileURL = panel.url?.appending(path: "Recording \(Date()).mov") {
                        try await setupAndRecordWindow(url: fileURL)
                    }
                }
            } catch {
                /// handle errors
                print(error.localizedDescription)
            }
        }
    }
}


extension ScreenRecorder {
    func setupWindowPicker() {
        let picker = SCContentSharingPicker.shared
        
        var pickerConfiguration = SCContentSharingPickerConfiguration()
        pickerConfiguration.allowedPickerModes = .singleWindow
        pickerConfiguration.allowsChangingSelectedContent = false
        
        picker.configuration = pickerConfiguration
        
        // Remove existing observer registration if needed to avoid duplicate calls, then add
        picker.remove(self)
        picker.add(self)
        
        // Activate and present
        picker.isActive = true
        picker.present()
    }
    
    func contentSharingPicker(_ picker: SCContentSharingPicker, didCancelFor stream: SCStream?) {
        picker.isActive = false
    }
    
    func contentSharingPicker(_ picker: SCContentSharingPicker, didUpdateWith filter: SCContentFilter, for stream: SCStream?) {
        /// window has been selected; close picker and prompt for file save
        picker.isActive = false
        self.contentFilter = filter
        
        self.askFileLocation()
    }
    
    func contentSharingPickerStartDidFailWithError(_ error: any Error) {
        print("Picker failed to start: \(error.localizedDescription)")
    }
}


/// Setting up new window picker by screen-capture-kit
