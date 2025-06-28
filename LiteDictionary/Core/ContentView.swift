//
//  ContentView.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import SwiftUI
import KeyboardShortcuts

struct ContentView: View {

    @ObservedObject var contentModel = ContentModel()
    @State private var searchText: String = ""
    @State private var showingSubSettingPanel = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            getSearchInputView()
            getContentArea()
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(width: 400)
        .onReceive(NotificationCenter.default.publisher(for: .popoverWillClose)) { _ in
            showingSubSettingPanel = false
        }
    }

    private func getSearchInputView() -> some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black)
                .padding(.leading, 10)

            TextField("查询快捷键 \(KeyboardShortcuts.getShortcut(for: .togglePopover)?.description ?? "未设置")", text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .frame(width: 350, height: 24)
                .onSubmit {
                    contentModel.fetchHTMLPage(searchText: searchText)
                }
                .onChange(of: searchText) { newValue in
                    if newValue.isEmpty {
                        contentModel.dictResponse = nil
                    }
                }
        }
        .background(Color.white)
        .cornerRadius(8)
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 15)
    }

    private func getContentArea() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            ViewUtils.divider

            if let dictResponse = contentModel.dictResponse, dictResponse.code == 200, !searchText.isEmpty {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        DictContentView(dictResponse: dictResponse)
                    }
                }
                .frame(maxHeight: 300)
            } else {
                SettingsView(showingSubSettingPanel: $showingSubSettingPanel)
            }
        }
        .background(
            (contentModel.dictResponse != nil && contentModel.dictResponse?.code == 200 && !searchText.isEmpty) ? Color.white : Color.clear
        )
    }
}
