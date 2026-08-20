//
//  titanApp.swift
//  titan
//
//  Created by Tristan on 8/19/26.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    // Keep app running in menu bar even when IntroView window closes
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
}

@main
struct titanApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("isUserIntroCompleted") private var isUserIntroCompleted: Bool = false
    @State private var introScreenShowed: Bool = false
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        // Show menu bar item IF intro is completed (or always show it)
        MenuBarExtra(
            "Mac Recorder",
            systemImage: "inset.filled.rectangle.badge.record",
            isInserted: $isUserIntroCompleted
        ) {
            MenuView()
        }
        .menuBarExtraStyle(.window)

        WindowGroup(id: "IntroView") {
            IntroView()
        }
        .windowLevel(.floating)
        .windowStyle(.plain)
        .restorationBehavior(.disabled)
        .defaultWindowPlacement { content, context in
            let displaySize = context.defaultDisplay.visibleRect.size
            let size = content.sizeThatFits(.init(displaySize))
            return .init(.center, size: size)
        }
        .onChange(of: scenePhase, initial: true) { _, _ in
            // Open Intro window only if user has NOT completed it yet
            if !isUserIntroCompleted && !introScreenShowed {
                openWindow(id: "IntroView")
                introScreenShowed = true
            }
        }
    }
}
