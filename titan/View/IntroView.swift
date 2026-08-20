//
//  IntroView.swift
//  titan
//
//  Created by Tristan on 8/19/26.
//

import SwiftUI

struct IntroView: View {
    @AppStorage("isUserIntroCompleted") private var isUserIntroCompleted: Bool = false
    @Environment(\.dismissWindow) private var dismissWindow
    var body: some View {
        VStack(spacing: 15) {
            Text("What's new in \n Mac Recorder")
                .font(.system(size: 35, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.bottom, 35)
            
            // Points
            VStack(alignment: .leading, spacing: 25) {
                PointView(
                    title: "Record Screen",
                    image: "video.fill",
                    description: "Capture your screen with high-quality recordings."
                )
                PointView(
                    title: "Select Window",
                    image: "macwindow",
                    description: "Easily select any window for focused recording using ScreenCaptureKit."
                )
                PointView(
                    title: "Save Recording",
                    image: "folder.fill",
                    description: "Save your recordings to your desire location with a click."
                )
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 60)
            /// Continue / Quit Button
            HStack(spacing: 10) {
                
                PrimaryButton(
                    title: "Quit App",
                    foregroundStyle: .white,
                    backgroundStyle: .red.gradient) {
                    NSApplication.shared.terminate(nil)

                }
            
                PrimaryButton(
                    title: "Start Using Mac Recorder",
                    foregroundStyle: .background,
                    backgroundStyle: Color.primary.gradient) {
                    isUserIntroCompleted = true
                    /// Closing current window
                    dismissWindow(id: "IntroView"
                    )
                }
            }
        }
        .padding(30)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 15))
        .gesture(WindowDragGesture())
    }
    
    @ViewBuilder
    func PointView(title: String, image: String, description: String) -> some View {
        HStack(spacing: 15) {
            Image(systemName: image)
                .font(.largeTitle)
                .foregroundStyle(.primary)
                .frame(width: 35)
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.callout)
                    .foregroundStyle(.gray)
                
            }
        }
    }
}

#Preview {
    IntroView()
}
