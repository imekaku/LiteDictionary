//
//  SettingsView.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import Foundation
import SwiftUI
import KeyboardShortcuts

struct SettingsView: View {

    @Binding var showingSubSettingPanel: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if showingSubSettingPanel {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Record the shortcut").bold()
                        Spacer()
                        KeyboardShortcuts.Recorder(for: .togglePopover)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)

                    MenuItem(title: "Back") {
                        showingSubSettingPanel = false
                    }
                }
                .padding(.top, 5)
            } else {
                MenuItem(title: "Setting") {
                    showingSubSettingPanel = true
                }

                MenuItem(title: "Quit") {
                    NSApplication.shared.terminate(nil)
                }
            }
        }
        .padding(.top, 5)
        .padding(.bottom, 7)
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .frame(width: 400)
    }
}
