//
//  ContentView.swift
//  QuickCode iOS App Clip
//
//  Created by Mark Howard on 23/10/2024.
//

import SwiftUI
import CodeMirror_SwiftUI

struct ContentView: View {
    //Load Undo/Redo Manager
    @Environment(\.undoManager) var undoManager
    //Document Text
    @State private var documentText = ""
    var body: some View {
        NavigationStack {
            //Code Editor View
            CodeView(theme: .zenburnesque, code: $documentText, mode: CodeMode.mode(.text)(), fontSize: 12, showInvisibleCharacters: false, lineWrapping: true)
            //Error If The Editor Fails To Load
                .onLoadFail { error in
                    print("Load Failed: \(error.localizedDescription)")
                }
            //Navigation App Title
                .navigationTitle("QuickCode")
                .navigationBarTitleDisplayMode(.inline)
            //Toolbar Of Quick Actions
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(action: {undoManager?.undo()}) {
                            Label("Undo", systemImage: "arrow.uturn.backward")
                        }
                        .help("Undo")
                    }
                    ToolbarItem(placement: .navigation) {
                        Button(action: {undoManager?.redo()}) {
                            Label("Redo", systemImage: "arrow.uturn.forward")
                        }
                        .help("Redo")
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {copyToClipBoard(textToCopy: documentText)}) {
                            Label("Copy", systemImage: "text.badge.plus")
                        }
                        .help("Copy Text")
                        .keyboardShortcut("c", modifiers: [.command, .shift])
                    }
                    ToolbarItem(placement: .primaryAction) {
                        ShareLink(items: [documentText]) {
                            Label("Share", systemImage: "square.and.arrow.up")
                        }
                        .help("Share")
                    }
                }
        }
    }
    //Copy The Whole Document To The Clipboard
    private func copyToClipBoard(textToCopy: String) {
        let paste = UIPasteboard.general
        paste.string = textToCopy
    }
}

#Preview {
    ContentView()
}
