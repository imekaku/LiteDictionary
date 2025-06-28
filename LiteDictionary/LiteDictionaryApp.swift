//
//  LiteDictionaryApp.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import SwiftUI

@main
struct LiteDictionaryApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
