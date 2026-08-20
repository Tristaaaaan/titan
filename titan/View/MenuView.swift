//
//  MenuView.swift
//  titan
//
//  Created by Tristan on 8/20/26.
//

import SwiftUI
import ScreenCaptureKit

let colors: [Color] = [.white, .red, .blue, .green, .yellow, .orange, .purple]

struct MenuView: View {
    @StateObject private var screenRecorder: ScreenRecorder = .init()
    @State private var isPermissionGranted: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Properties")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.bottom, -6)
                Toggle(isOn: $screenRecorder.showCursor) {
                    Text("Shows Cursor")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                Toggle(isOn: $screenRecorder.captureAudio) {
                    Text("Capture Audio")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                Picker("Background Color", selection: $screenRecorder.backgroundColor) {
                    ForEach(colors, id: \.self) {
                        color in
                        Text(String(describing: color).capitalized)
                            .tag(color)
                        
                    }
                }
                
                Picker("Video Scale", selection: $screenRecorder.videoScale) {
                    ForEach(VideoScale.allCases, id: \.rawValue) {
                        scale in
                        Text(scale.stringValue)
                            .tag(scale)
                        
                    }
                }.pickerStyle(.segmented)
            }
            .toggleStyle(.switch)
            .disabled(screenRecorder.isRecording)
            .opacity(screenRecorder.isRecording ? 0.5 : 1)
            
            /// Window Picker Button
            Button {
                if screenRecorder.isRecording {
                    screenRecorder.stopWindowRecording()
                } else {
                    /// Show window picker
                    screenRecorder.setupWindowPicker()
                }
            } label: {
                Text(screenRecorder.isRecording ? "Stop Recording" : "Choose Window")
                    .fontWeight(.semibold)
                    .foregroundStyle(.background)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 20)
                    .background(Color.primary.gradient, in: .rect(cornerRadius: 8))
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity)
            
            Button("Quit") {
                /// Quitting App
                NSApplication.shared.terminate(nil)
                
            }
            .buttonStyle(.plain)
            .pointerStyle(.link)
            .foregroundStyle(.red)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 5)
            .disabled(screenRecorder.isRecording)
            
        }.padding(15)
            .frame(width: 240)
            .overlay {
                if !isPermissionGranted {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .overlay {
                            Text("No Screen Recording Permission\nPlease grant permission in System Preferences")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(Color.primary)
                        }
                }
            }
            .onAppear {
                isPermissionGranted = CGRequestScreenCaptureAccess()
            }
        
    }
}

#Preview {
    MenuView()
}
