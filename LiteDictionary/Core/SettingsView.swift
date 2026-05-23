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
    @StateObject private var loginItemHelper = LoginItemHelper.shared

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if showingSubSettingPanel {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("查询快捷键").bold()
                        Spacer()
                        KeyboardShortcuts.Recorder(for: .togglePopover)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)

                    HStack {
                        Text("开机自动启动").bold()
                        Spacer()
                        Toggle("", isOn: $loginItemHelper.isEnabled)
                            .toggleStyle(.switch)
                            .labelsHidden()
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)

                    HStack {
                        Text("版本号").bold()
                        Spacer()
                        Text(getAppVersion())
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4)

                    MenuItem(title: "返回") {
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

    private func getAppVersion() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.02"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }
}
