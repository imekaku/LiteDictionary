//
//  AppDelegate.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import Foundation
import Cocoa
import SwiftUI
import KeyboardShortcuts

class AppDelegate: NSObject, NSApplicationDelegate, NSPopoverDelegate {
    var statusItem: NSStatusItem!
    var popover: NSPopover!
    var statusBarController: StatusBarController!

    func applicationDidFinishLaunching(_ notification: Notification) {
        popover = NSPopover()
        popover.animates = true
        popover.behavior = .transient
        popover.contentSize = .zero
        popover.contentViewController = NSHostingController(rootView: ContentView())
        popover.delegate = self

        statusBarController = StatusBarController(popover: popover)

        // 注册快捷键监听
        KeyboardShortcuts.onKeyUp(for: .togglePopover) { [weak statusBarController] in
            statusBarController?.togglePopover(nil)
        }
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }

    func popoverWillClose(_ notification: Notification) {
        // 自动通知视图关闭
        NotificationCenter.default.post(name: .popoverWillClose, object: nil)
    }
}

extension KeyboardShortcuts.Name {
    static let togglePopover = Self("togglePopover")
}

extension Notification.Name {
    static let popoverWillClose = Notification.Name("popoverWillClose")
}
