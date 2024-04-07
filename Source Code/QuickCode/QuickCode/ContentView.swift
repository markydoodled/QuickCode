//
//  ContentView.swift
//  QuickCode
//
//  Created by Mark Howard on 01/04/2024.
//

import SwiftUI
import CodeMirror_SwiftUI
import AppKit

struct ContentView: View {
    //Load In Document
    @Binding var document: QuickCodeDocument
    
    //Load Undo/Redo Manager
    @Environment(\.undoManager) var undoManager

    //Load In Settings
    @State var editor = EditorSettings()
    @State var themes = ThemeSettings()
    
    //Create Metadata Stores
    @State var fileURL: URL
    @State var fileTypeAttribute: String
    @State var fileSizeAttribute: Int64
    @State var fileTitleAtribute: String
    @State var fileCreatedAttribute: Date
    @State var fileModifiedAttribute: Date
    @State var fileExtensionAttribute: String
    @State var fileOwnerAttribute: String
    @State var filePathAttribute: String
    private let fileByteCountFormatter: ByteCountFormatter = {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useAll]
        bcf.countStyle = .file
        return bcf
    }()
    
    //Store Forced App Appearance
    @AppStorage("selectedAppearance") var selectedAppearance = 3
    //Store Inspector State
    @AppStorage("showingInspector") var showingInspector = false
    //Showing Export View State
    @State var showingExport = false
    
    //Setup File Exporter Sheet Trackers
    @State var isShowingSwiftSourceExport = false
    @State var isShowingPlainTextExport = false
    @State var isShowingXMLExport = false
    @State var isShowingYAMLExport = false
    @State var isShowingJSONExport = false
    @State var isShowingHTMLExport = false
    @State var isShowingAssemblyExport = false
    @State var isShowingCHeaderExport = false
    @State var isShowingCSourceExport = false
    @State var isShowingCPlusPlusHeaderExport = false
    @State var isShowingCPlusPlusSourceExport = false
    @State var isShowingObjectiveCPlusPlusSourceExport = false
    @State var isShowingObjectiveCSourceExport = false
    @State var isShowingAppleScriptExport = false
    @State var isShowingJavaScriptExport = false
    @State var isShowingShellScriptExport = false
    @State var isShowingPythonScriptExport = false
    @State var isShowingRubyScriptExport = false
    @State var isShowingPerlScriptExport = false
    @State var isShowingPHPScriptExport = false
    var body: some View {
        //Code Editor View
        GeometryReader { reader in
            ScrollView {
                CodeView(theme: themes.theme, code: $document.text, mode: themes.syntax.mode(), fontSize: editor.fontSize, showInvisibleCharacters: editor.showInvisibleCharacters, lineWrapping: editor.lineWrapping)
                    .onLoadSuccess {
                        fileURL = NSDocumentController().currentDocument?.fileURL ?? URL(string: "/")!
                        getAttributes()
                    }
                    .onLoadFail { error in
                        print("Load Failed: \(error.localizedDescription)")
                    }
                    .onContentChange { change in
                        fileURL = NSDocumentController().currentDocument?.fileURL ?? URL(string: "/")!
                        getAttributes()
                    }
                    .frame(height: reader.size.height)
            }
            .frame(height: reader.size.height)
        }
        .inspector(isPresented: $showingInspector) {
            //Right Inspector Sidebar Of File Metadata
            Form {
                Section {
                    Text("\(NSDocumentController().currentDocument?.displayName ?? "None")")
                } header: {
                    Label("Title", systemImage: "textformat")
                }
                .collapsible(false)
                Section {
                    Text("\(fileExtensionAttribute)")
                } header: {
                    Label("Extension", systemImage: "square.grid.3x1.folder.badge.plus")
                }
                .collapsible(false)
                Section {
                    Text("\(fileByteCountFormatter.string(fromByteCount: fileSizeAttribute))")
                } header: {
                    Label("Size", systemImage: "externaldrive")
                }
                .collapsible(false)
                Section {
                    Text("\(filePathAttribute)")
                } header: {
                    Label("Path", systemImage: "point.topleft.down.curvedto.point.bottomright.up")
                }
                .collapsible(false)
                Section {
                    Text("\(fileOwnerAttribute)")
                } header: {
                    Label("Owner", systemImage: "person")
                }
                .collapsible(false)
                Section {
                    Text("\(fileCreatedAttribute.formatted(.dateTime))")
                } header: {
                    Label("Created", systemImage: "calendar.badge.plus")
                }
                .collapsible(false)
                Section {
                    Text("\(fileModifiedAttribute.formatted(.dateTime))")
                } header: {
                    Label("Modified", systemImage: "calendar.badge.clock")
                }
                .collapsible(false)
                Section {
                    Text("\(fileTypeAttribute)")
                } header: {
                    Label("File Type", systemImage: "doc")
                }
                .collapsible(false)
            }
        }
        //Customisable Toolbar Of Quick Actions
            .toolbar(id: "quick-actions") {
                Group {
                    ToolbarItem(id: "undo", placement: .navigation) {
                        Button(action: {undoManager?.undo()}) {
                            Label("Undo", systemImage: "arrow.uturn.backward")
                        }
                        .help("Undo")
                    }
                    ToolbarItem(id: "redo", placement: .navigation) {
                        Button(action: {undoManager?.redo()}) {
                            Label("Redo", systemImage: "arrow.uturn.forward")
                        }
                        .help("Redo")
                    }
                    ToolbarItem(id: "update-metadata", placement: .primaryAction) {
                        Button(action: {
                            fileURL = NSDocumentController().currentDocument?.fileURL ?? URL(string: "/")!
                            getAttributes()
                        }) {
                            Label("Update Metadata", systemImage: "arrow.counterclockwise")
                        }
                        .help("Update Metadata")
                        .keyboardShortcut("r")
                    }
                    ToolbarItem(id: "file-inspector", placement: .primaryAction) {
                        Button(action: {showingInspector.toggle()}) {
                            Label("File Inspector", systemImage: "sidebar.right")
                        }
                        .help("Toggle File Inspector")
                    }
                    ToolbarItem(id: "new-doc", placement: .secondaryAction) {
                        Button(action: {NSDocumentController().newDocument(Any?.self)}) {
                            Label("New", systemImage: "doc.badge.plus")
                        }
                        .help("New Document")
                    }
                    ToolbarItem(id: "open-doc", placement: .secondaryAction) {
                        Button(action: {NSDocumentController().openDocument(Any?.self)}) {
                            Label("Open", systemImage: "doc.badge.arrow.up")
                        }
                        .help("Open Document")
                    }
                    ToolbarItem(id: "save-doc", placement: .secondaryAction) {
                        Button(action: {NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)}) {
                            Label("Save", systemImage: "square.and.arrow.down")
                        }
                        .help("Save Document")
                    }
                    ToolbarItem(id: "copy-doc", placement: .secondaryAction) {
                        Button(action: {copyToClipBoard(textToCopy: document.text)}) {
                            Label("Copy", systemImage: "text.badge.plus")
                        }
                        .help("Copy Document Text")
                        .keyboardShortcut("c", modifiers: [.command, .shift])
                    }
                    ToolbarItem(id: "move-doc", placement: .secondaryAction) {
                        Button(action: {NSApp.sendAction(#selector(NSDocument.move(_:)), to: nil, from: self)}) {
                            Label("Move", systemImage: "folder")
                        }
                        .help("Move Document")
                    }
                    ToolbarItem(id: "duplicate-doc", placement: .secondaryAction) {
                        Button(action: {NSApp.sendAction(#selector(NSDocument.duplicate(_:)), to: nil, from: self)}) {
                            Label("Duplicate", systemImage: "doc.on.doc")
                        }
                        .help("Duplicate Document")
                    }
                }
                Group {
                    ToolbarItem(id: "change-appearance", placement: .secondaryAction) {
                        Menu {
                            Button(action: {selectedAppearance = 1}) {
                                Text("Light")
                            }
                            Button(action: {selectedAppearance = 2}) {
                                Text("Dark")
                            }
                            Button(action: {selectedAppearance = 3}) {
                                Text("System")
                            }
                        } label: {
                            Label("Appearance", systemImage: "cloud.sun")
                        }
                        .help("Change Appearance")
                    }
                    ToolbarItem(id: "export", placement: .secondaryAction) {
                        Button(action: {showingExport = true}) {
                            Label("Export", systemImage: "square.and.arrow.up.on.square")
                        }
                        .help("Export Document")
                        .popover(isPresented: $showingExport) {
                            export
                        }
                    }
                }
            }
            .toolbarRole(.editor)
        //TouchBar Of Quick Actions
        /*.touchBar {
            Button(action: {
                fileURL = NSDocumentController().currentDocument?.fileURL ?? URL(string: "/")!
                getAttributes()
            }) {
                Label("Metadata", systemImage: "arrow.counterclockwise")
            }
            Button(action: {NSDocumentController().newDocument(Any?.self)}) {
                Label("New", systemImage: "doc.badge.plus")
            }
            Button(action: {NSDocumentController().openDocument(Any?.self)}) {
                Label("Open", systemImage: "doc.badge.arrow.up")
            }
            Button(action: {NSApp.sendAction(#selector(NSDocument.save(_:)), to: nil, from: self)}) {
                Label("Save", systemImage: "square.and.arrow.down")
            }
            Button(action: {copyToClipBoard(textToCopy: document.text)}) {
                Label("Copy", systemImage: "text.badge.plus")
            }
            Button(action: {NSApp.sendAction(#selector(NSDocument.move(_:)), to: nil, from: self)}) {
                Label("Move", systemImage: "folder")
            }
            Button(action: {NSApp.sendAction(#selector(NSDocument.duplicate(_:)), to: nil, from: self)}) {
                Label("Duplicate", systemImage: "doc.on.doc")
            }
        }*/
        //Set The Appearance When The App Window Is Loaded
        .onAppear() {
            if selectedAppearance == 1 {
                NSApp.appearance = NSAppearance(named: .aqua)
            } else if selectedAppearance == 2 {
                NSApp.appearance = NSAppearance(named: .darkAqua)
            } else {
                NSApp.appearance = nil
            }
            fileURL = NSDocumentController().currentDocument?.fileURL ?? URL(string: "/")!
            getAttributes()
        }
        //Chance The App Window Appearance When The Toggle Is Changed
        .onChange(of: selectedAppearance) {
            if selectedAppearance == 1 {
                NSApp.appearance = NSAppearance(named: .aqua)
            } else if selectedAppearance == 2 {
                NSApp.appearance = NSAppearance(named: .darkAqua)
            } else {
                NSApp.appearance = nil
            }
        }
    }
    //Form Showing Export Options, File Print Button And File Exporters
    var export: some View {
        List {
            Group {
                Button(action: {isShowingSwiftSourceExport.toggle()}) {
                    Text("Swift")
                }
                .fileExporter(isPresented: $isShowingSwiftSourceExport, document: document, contentType: .swiftSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingPlainTextExport.toggle()}) {
                    Text("Plain Text")
                }
                .fileExporter(isPresented: $isShowingPlainTextExport, document: document, contentType: .plainText, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingXMLExport.toggle()}) {
                    Text("XML")
                }
                .fileExporter(isPresented: $isShowingXMLExport, document: document, contentType: .xml, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingYAMLExport.toggle()}) {
                    Text("YAML")
                }
                .fileExporter(isPresented: $isShowingYAMLExport, document: document, contentType: .yaml, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingJSONExport.toggle()}) {
                    Text("JSON")
                }
                .fileExporter(isPresented: $isShowingJSONExport, document: document, contentType: .json, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingHTMLExport.toggle()}) {
                    Text("HTML")
                }
                .fileExporter(isPresented: $isShowingHTMLExport, document: document, contentType: .html, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingAssemblyExport.toggle()}) {
                    Text("Assembly")
                }
                .fileExporter(isPresented: $isShowingAssemblyExport, document: document, contentType: .assemblyLanguageSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingCHeaderExport.toggle()}) {
                    Text("C Header")
                }
                .fileExporter(isPresented: $isShowingCHeaderExport, document: document, contentType: .cHeader, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingCSourceExport.toggle()}) {
                    Text("C Source")
                }
                .fileExporter(isPresented: $isShowingCSourceExport, document: document, contentType: .cSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingCPlusPlusHeaderExport.toggle()}) {
                    Text("C++ Header")
                }
                .fileExporter(isPresented: $isShowingCPlusPlusHeaderExport, document: document, contentType: .cPlusPlusHeader, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            Group {
                Button(action: {isShowingCPlusPlusSourceExport.toggle()}) {
                    Text("C++ Source")
                }
                .fileExporter(isPresented: $isShowingCPlusPlusSourceExport, document: document, contentType: .cPlusPlusSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingObjectiveCPlusPlusSourceExport.toggle()}) {
                    Text("Objective C++")
                }
                .fileExporter(isPresented: $isShowingObjectiveCPlusPlusSourceExport, document: document, contentType: .objectiveCPlusPlusSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingObjectiveCSourceExport.toggle()}) {
                    Text("Objective C")
                }
                .fileExporter(isPresented: $isShowingObjectiveCSourceExport, document: document, contentType: .objectiveCSource, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingAppleScriptExport.toggle()}) {
                    Text("AppleScript")
                }
                .fileExporter(isPresented: $isShowingAppleScriptExport, document: document, contentType: .appleScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingJavaScriptExport.toggle()}) {
                    Text("JavaScript")
                }
                .fileExporter(isPresented: $isShowingJavaScriptExport, document: document, contentType: .javaScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingShellScriptExport.toggle()}) {
                    Text("Shell Script")
                }
                .fileExporter(isPresented: $isShowingShellScriptExport, document: document, contentType: .shellScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingPythonScriptExport.toggle()}) {
                    Text("Python")
                }
                .fileExporter(isPresented: $isShowingPythonScriptExport, document: document, contentType: .pythonScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingRubyScriptExport.toggle()}) {
                    Text("Ruby")
                }
                .fileExporter(isPresented: $isShowingRubyScriptExport, document: document, contentType: .rubyScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingPerlScriptExport.toggle()}) {
                    Text("Perl")
                }
                .fileExporter(isPresented: $isShowingPerlScriptExport, document: document, contentType: .perlScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button(action: {isShowingPHPScriptExport.toggle()}) {
                    Text("PHP")
                }
                .fileExporter(isPresented: $isShowingPHPScriptExport, document: document, contentType: .phpScript, defaultFilename: "Exported File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    //Fetch The File Metadata Attributes
    func getAttributes() {
        let creationDate = fileURL.creationDate
        let modificationDate = fileURL.modificationDate
        let type = fileURL.fileType
        let owner = fileURL.fileOwner
        let size = fileURL.fileSize
        let fileextension = fileURL.pathExtension
        let filePath = fileURL.path
        
        filePathAttribute = filePath
        fileExtensionAttribute = fileextension
        fileSizeAttribute = Int64(size)
        fileOwnerAttribute = owner
        fileTypeAttribute = type
        fileModifiedAttribute = modificationDate!
        fileCreatedAttribute = creationDate!
    }
    //Copy The Whole Document To The Clipboard
    private func copyToClipBoard(textToCopy: String) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(textToCopy, forType: .string)
    }
}

//Fetch Metadata Keys Through URL Extension
extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute Error: \(error)")
        }
        return nil
    }

    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }

    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }

    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
    
    var fileType: String {
        return attributes?[.type] as? String ?? ""
    }
    
    var modificationDate: Date? {
        return attributes?[.modificationDate] as? Date
    }
    
    var fileOwner: String {
        return attributes?[.ownerAccountName] as? String ?? ""
    }
}

#Preview {
    ContentView(document: .constant(QuickCodeDocument()), fileURL: URL(string: "/")!, fileTypeAttribute: "", fileSizeAttribute: 0, fileTitleAtribute: "", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "", fileOwnerAttribute: "", filePathAttribute: "")
}
