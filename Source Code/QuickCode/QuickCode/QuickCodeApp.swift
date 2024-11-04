//
//  QuickCodeApp.swift
//  QuickCode
//
//  Created by Mark Howard on 01/04/2024.
//

import SwiftUI

@main
struct QuickCodeApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        //Create Document Window For Editor
        DocumentGroup(newDocument: QuickCodeDocument()) { file in
            ContentView(document: file.$document, fileURL: URL(string: "/")!, fileTypeAttribute: "N/A", fileSizeAttribute: 0, fileTitleAtribute: "N/A", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "N/A", fileOwnerAttribute: "N/A", filePathAttribute: "N/A")
                .frame(minWidth: 850, minHeight: 400)
                .focusedSceneValue(\.document, file.$document)
        }
        //Load Menu Bar Commands
        .commands {
            InspectorCommands()
            ToolbarCommands()
        }
        //Set System Settings Window
        Settings {
            SettingsView()
                .frame(width: 600, height: 400)
        }
    }
}

//Link Document To Other Views
extension FocusedValues {
    struct DocumentFocusedValues: FocusedValueKey {
        typealias Value = Binding<QuickCodeDocument>
    }
    var document: Binding<QuickCodeDocument>? {
        get {
            self[DocumentFocusedValues.self]
        }
        set {
            self[DocumentFocusedValues.self] = newValue
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDockMenu(_ sender: NSApplication) -> NSMenu? {
        let menu = NSMenu()
        menu.addItem(withTitle: "New Document", action: #selector(newDocument), keyEquivalent: "")
        return menu
    }
    
    @objc func newDocument() {
        NSDocumentController().newDocument(Any?.self)
    }
}
