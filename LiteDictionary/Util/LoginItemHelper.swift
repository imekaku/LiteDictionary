//
//  LoginItemHelper.swift
//  LiteDictionary
//
//  Created by Claude on 2026/05/23.
//

import Foundation
import ServiceManagement

class LoginItemHelper: ObservableObject {
    static let shared = LoginItemHelper()

    private let launcherAppId = "com.imekaku.LiteDictionaryLauncher"
    private let enabledKey = "LoginItemEnabled"

    @Published var isEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isEnabled, forKey: enabledKey)
            updateLoginItemStatus()
        }
    }

    private init() {
        self.isEnabled = UserDefaults.standard.bool(forKey: enabledKey)
    }

    func updateLoginItemStatus() {
        let service = SMAppService.mainApp

        do {
            if isEnabled {
                if service.status != .enabled {
                    try service.register()
                }
            } else {
                if service.status == .enabled {
                    try service.unregister()
                }
            }
        } catch {
            print("Failed to update login item status: \(error)")
        }
    }

    func checkCurrentStatus() -> Bool {
        return SMAppService.mainApp.status == .enabled
    }
}
