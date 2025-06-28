A simple demo chat interface implemented in SwiftUI, following Clean Architecture, MVVM, SOLID principles, and powered by Combine. This project is designed for interview submission and demonstrates testability, maintainability, and scalable design.

✅ Features

SwiftUI chat screen UI

MVVM + Clean Architecture

Dependency Injection for all components

Send & auto-reply simulation using Combine

Tick indicators: pending, delivered (✔), and read (✔✔)

Unit tests with mocks for services and use cases

UI tests with accessibility identifiers

🧱 Architecture Overview

Presentation (View + ViewModel)
│
├── ChatView.swift
├── ChatViewModel.swift
│
├── Use Cases
│   ├── SendMessageUseCase
│   └── ReplyMessageUseCase
│
├── Services
│   ├── SendMessageServiceProvider
│   └── ReplyServiceProvider
│
├── Models
│   └── ChatMessage

Each layer is decoupled via protocol abstraction and injected through initializers.

🧪 Unit Testing

Located in ChatViewModelTests.swift

Covers:

Sending message appends correctly

Auto reply works after delay

Message is marked as read

Run:

⌘U (Cmd + U) in Xcode

🔬 UI Testing

UI elements use accessibilityIdentifier for targeting:

TextField: "Type a message"

Send Button: "Send"

Add a UITest target and assert chat flow behavior using XCUITest.

💬 Tick Indicator Logic

✅ Single tick: Delivered

✅✅ Double tick: Read

⏳ Waiting: Not delivered

Refactored into reusable MessageStatusView

Uses SF Symbols fallback or emojis: "✔", "✔✔", "⌛"

You can also drop tick-single, tick-double, tick-waiting images in Assets.xcassets to override.

🛠 Setup & Run

Open in Xcode 15+

Run the app in iOS Simulator

Preview

SwiftUI live preview included for ChatView

🧰 Tech Stack

Swift 5.9+

SwiftUI

Combine

XCTest

SOLID Principles

No third-party libraries

📁 Folder Suggestions

Organize your codebase like:

├── Core
│   ├── Models
│   ├── UseCases
│   └── Services
├── Presentation
│   ├── Views
│   └── ViewModels
├── Resources
│   └── Assets.xcassets
├── Tests
│   └── Unit

📞 Contact

Made by Aklesh Rathaur — LinkedIn | akleshrathaur23@gmail.com
