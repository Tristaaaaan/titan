# TITAN

A native macOS screen recorder built with Swift and `ScreenCaptureKit`.

## Overview

TITAN is a screen recorder for macOS. Built on Apple's modern `ScreenCaptureKit` framework, it captures your screen with minimal overhead and native quality. This project started from a tutorial build and is being extended with additional features — most notably automatic zoom and pan.

## Features

- Screen recording via `ScreenCaptureKit` (macOS 13+)
- System audio and microphone capture
- Export to high-quality video output
- Simple, native macOS interface

## Roadmap

- [ ] **Auto Zoom & Pan** — automatically track cursor activity and focus areas during recording (or in post-processing) to smoothly zoom and pan the video, similar to presentation-style screen recordings. This is the primary feature currently in development.

## Requirements

- macOS 13.0 (Ventura) or later
- Xcode 15+ (for building from source)
- Screen Recording permission (macOS will prompt on first launch)

## Installation

### From Source

```bash
git clone https://github.com/yourusername/titan.git
cd titan
open TITAN.xcodeproj
```

Build and run using `Cmd + R` in Xcode.

## Usage

1. Launch TITAN.
2. Grant Screen Recording permission when prompted.
3. Select your capture source (screen/display).
4. Click **Record** to start, and stop when finished.
5. Your recording is saved to the configured output location.

## Permissions

On first launch, macOS will ask you to grant **Screen Recording** access under:
`System Settings → Privacy & Security → Screen Recording`

If audio capture is enabled, you may also need to grant **Microphone** access.

## Credits

This project was built starting from a public tutorial on `ScreenCaptureKit`-based screen recording in Swift, then extended with custom features.

## Contributing

Contributions are welcome, especially around the upcoming Auto Zoom & Pan feature:

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/auto-zoom-pan`)
3. Commit your changes
4. Open a pull request

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

_Built with Swift & ScreenCaptureKit for macOS._
