//
//  ContentView.swift
//  QuickCode iOS
//
//  Created by Mark Howard on 01/04/2024.
//

import SwiftUI
import UniformTypeIdentifiers
import CodeMirror_SwiftUI

struct ContentView: View {
    //Load In Document
    @Binding var document: QuickCode_iOSDocument

    //Load Undo/Redo Manager
    @Environment(\.undoManager) var undoManager
    
    //Load In Editor And Theme Settings
    @State var editor = EditorSettings()
    @State var themes = ThemesSettings()
    
    //Create Metadata Stores
    @State var fileURL: URL
    @State var fileTypeAttribute: String
    @State var fileSizeAttribute: Int64
    @State var fileTitleAtribute: String
    @State var fileCreatedAttribute: Date
    @State var fileModifiedAttribute: Date
    @State var fileExtensionAttribute: String
    @State var fileOwnerAttribute: String
    @State var fileNameAttribute: String
    @State var filePathAttribute: String
    private let fileByteCountFormatter: ByteCountFormatter = {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useAll]
        bcf.countStyle = .file
        return bcf
    }()
    
    //Setup Appearance Tracker
    @AppStorage("selectedAppearance") var selectedAppearance = 3
    //Store Inspector State
    @AppStorage("showingInspector") var showingInspector = false
    //Showing Settings View State
    @State var showingSettings = false
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
        CodeView(theme: themes.theme, code: $document.text, mode: themes.syntax.mode(), fontSize: editor.fontSize, showInvisibleCharacters: editor.showInvisibleCharacters, lineWrapping: editor.lineWrapping)
        //On Editor Load Get File Attributes
            .onLoadSuccess {
                getAttributes()
            }
        //Error If The Editor Fails To Load
            .onLoadFail { error in
                print("Load Failed: \(error.localizedDescription)")
            }
        //Refetch The Attributes If The Document Contents Is Changed
            .onContentChange { change in
                getAttributes()
            }
        //Set The Appearance On View Load
            .onAppear {
                if selectedAppearance == 1 {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
                } else if selectedAppearance == 2 {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
                } else {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .unspecified
                }
            }
        //Change The App Appearance If The Picker Changes
            .onChange(of: selectedAppearance) {
                if selectedAppearance == 1 {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
                } else if selectedAppearance == 2 {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
                } else {
                    UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .unspecified
                }
            }
        //Toolbar Of Quick Actions
        .toolbar(id: "quick-actions") {
            ToolbarItem(id: "settings", placement: .primaryAction) {
                Button(action: {showingSettings = true}) {
                    Label("Settings", systemImage: "gearshape")
                }
                .help("Settings")
                .keyboardShortcut(",")
            }
            ToolbarItem(id: "update-metadata", placement: .primaryAction) {
                Button(action: {getAttributes()}) {
                    Label("Update Metadata", systemImage: "arrow.counterclockwise")
                }
                .help("Update Metadata")
                .keyboardShortcut("r")
            }
            ToolbarItem(id: "metadata", placement: .primaryAction) {
                Button(action: {showingInspector.toggle()}) {
                    Label("Metadata", systemImage: "sidebar.right")
                }
                .help("Metadata")
                .keyboardShortcut("i")
            }
            ToolbarItem(id: "undo", placement: .secondaryAction) {
                Button(action: {undoManager?.undo()}) {
                    Label("Undo", systemImage: "arrow.uturn.backward")
                }
                .help("Undo")
            }
            ToolbarItem(id: "redo", placement: .secondaryAction) {
                Button(action: {undoManager?.redo()}) {
                    Label("Redo", systemImage: "arrow.uturn.forward")
                }
                .help("Redo")
            }
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
            ToolbarItem(id: "copy-doc", placement: .secondaryAction) {
                Button(action: {copyToClipBoard(textToCopy: document.text)}) {
                    Label("Copy", systemImage: "text.badge.plus")
                }
                .help("Copy Text")
                .keyboardShortcut("c", modifiers: [.command, .shift])
            }
            ToolbarItem(id: "export", placement: .secondaryAction) {
                Button(action: {showingExport = true}) {
                    Label("Export", systemImage: "square.and.arrow.up.on.square")
                }
                .help("Export")
                .keyboardShortcut("e")
                .sheet(isPresented: $showingExport) {
                    NavigationStack {
                        export
                    }
                }
            }
        }
        .sheet(isPresented: $showingSettings) {
            NavigationStack {
                SettingsView()
            }
        }
        .toolbarRole(.editor)
        .navigationBarTitleDisplayMode(.inline)
        .inspector(isPresented: $showingInspector) {
            //Form Showing File Metadata
            Form {
                Section {
                    Text("\(fileNameAttribute)")
                } header: {
                    Label("Title", systemImage: "textformat")
                }
                Section {
                    Text("\(fileExtensionAttribute)")
                } header: {
                    Label("Extension", systemImage: "square.grid.3x1.folder.badge.plus")
                }
                Section {
                    Text("\(fileByteCountFormatter.string(fromByteCount: fileSizeAttribute))")
                } header: {
                    Label("Size", systemImage: "externaldrive")
                }
                Section {
                    Text("\(filePathAttribute)")
                } header: {
                    Label("Path", systemImage: "point.topleft.down.curvedto.point.bottomright.up")
                }
                Section {
                    Text("\(fileOwnerAttribute)")
                } header: {
                    Label("Owner", systemImage: "person")
                }
                Section {
                    Text("\(fileCreatedAttribute.formatted(.dateTime))")
                } header: {
                    Label("Created", systemImage: "calendar.badge.plus")
                }
                Section {
                    Text("\(fileModifiedAttribute.formatted(.dateTime))")
                } header: {
                    Label("Modified", systemImage: "calendar.badge.clock")
                }
                Section {
                    Text("\(fileTypeAttribute)")
                } header: {
                    Label("File Type", systemImage: "doc")
                } footer: {
                    Text("Metadata Generated From Last Time The File Was Opened")
                }
            }
        }
    }
    //Form Showing Export Options, File Print Button And File Exporters
    var export: some View {
        Form {
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
        .navigationTitle("Export")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {showingExport = false}) {
                    Text("Done")
                }
            }
        }
    }
    //Fetch The File Attributes For The Open Document
    func getAttributes() {
        let creationDate = fileURL.creationDate
        let modificationDate = fileURL.modificationDate
        let type = fileURL.fileType
        let owner = fileURL.fileOwner
        let size = fileURL.fileSize
        let fileextension = fileURL.pathExtension
        let filePath = fileURL.path
        let fileName = fileURL.deletingPathExtension().lastPathComponent
        
        fileNameAttribute = fileName
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
        let paste = UIPasteboard.general
        paste.string = textToCopy
    }
}

//Fetch The File Attribute Keys From An Extension To URL
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

//Implement keyWindow For Appearance Changes
extension UIApplication {
    var keyWindow: UIWindow? {
        return self.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}

#Preview {
    ContentView(document: .constant(QuickCode_iOSDocument()), fileURL: URL(string: "/")!, fileTypeAttribute: "", fileSizeAttribute: 0, fileTitleAtribute: "", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "", fileOwnerAttribute: "", fileNameAttribute: "", filePathAttribute: "")
}
