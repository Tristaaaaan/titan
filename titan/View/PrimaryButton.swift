//
//  PrimaryButton.swift
//  titan
//
//  Created by Tristan on 8/20/26.
//

import SwiftUI

struct PrimaryButton<Foreground: ShapeStyle, Background: ShapeStyle>: View {
    let title: String
    let foregroundStyle: Foreground
    let backgroundStyle: Background
    let action: () -> Void

    init(
        title: String,
        foregroundStyle: Foreground,
        backgroundStyle: Background,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.foregroundStyle = foregroundStyle
        self.backgroundStyle = backgroundStyle
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .fontWeight(.bold)
                .foregroundStyle(foregroundStyle)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    backgroundStyle,
                    in: .rect(cornerRadius: 8)
                )
        }
        .buttonStyle(.plain)
    }
}
