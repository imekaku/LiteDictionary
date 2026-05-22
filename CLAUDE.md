# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

LiteDictionary is a lightweight macOS status bar dictionary app for Chinese-English translation. It displays as a menu bar icon that opens a popover for quick word lookups.

## Build Commands

This is a standard Xcode project. Build and run using:

```bash
# Build the project
xcodebuild -scheme LiteDictionary -configuration Debug build

# Build for release
xcodebuild -scheme LiteDictionary -configuration Release build

# Clean build
xcodebuild -scheme LiteDictionary clean
```

Or open in Xcode:
```bash
open LiteDictionary.xcodeproj
```

## Architecture

### App Structure
- **LiteDictionaryApp.swift**: App entry point. Uses `@NSApplicationDelegateAdaptor` to delegate to AppDelegate.
- **AppDelegate.swift**: Sets up the NSPopover and status bar on launch. Registers global keyboard shortcut listener via KeyboardShortcuts.
- **StatusBarController.swift**: Manages the NSStatusItem (menu bar icon) and handles popover show/hide.

### Core UI
- **ContentView.swift**: Main popover UI with search input. Shows DictContentView when results exist, otherwise SettingsView.
- **ContentModel.swift**: ObservableObject that fetches dictionary data from Bing Dictionary API and parses HTML response.
- **DictContentView.swift**: Displays search results: pronunciations, word definitions, and example sentences.
- **SettingsView.swift**: Settings panel shown when no search query is active.

### Data Layer
- **DictResponse.swift**: Aggregates pronunciation, word definitions, and sentences.
- **Word.swift**, **Pronunciation.swift**, **Sentence.swift**: Individual data models.

### Utilities
- **HttpUtils.swift**: HTTP GET requests with URLSession. Sets Safari-like User-Agent headers.
- **ParseUtils.swift**: HTML parsing using SwiftSoup to extract data from Bing Dictionary responses.
- **ViewUtils.swift**: Shared SwiftUI view helpers.

## Dependencies

Managed via Swift Package Manager (defined in Xcode project):
- **KeyboardShortcuts** (2.3.0): Global keyboard shortcut registration
- **SwiftSoup** (2.8.8): HTML parsing for Bing Dictionary responses

## Data Source

The app scrapes dictionary data from Bing Dictionary (cn.bing.com/dict/clientsearch). The HTML parsing logic in `ParseUtils.swift` depends on specific CSS selectors from Bing's response structure.

## Key Implementation Details

- Global keyboard shortcut (`.togglePopover`) is registered in `AppDelegate.applicationDidFinishLaunching`
- Popover uses `.transient` behavior to close when clicking outside
- Notification `.popoverWillClose` is posted when the popover closes, triggering UI state cleanup
- The app has no dock icon (LSUIElement is likely set in Info.plist)
