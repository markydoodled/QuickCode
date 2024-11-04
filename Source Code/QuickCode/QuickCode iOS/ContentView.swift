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
    //Add Environment Dismiss Action
    @Environment(\.dismiss) private var dismiss
    //Load In Editor And Theme Settings
    @State var settings = SettingsView()
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
    @State private var showingSettings = false
    //Showing Export View State
    @State private var showingExport = false
    //Setup File Exporter Sheet Trackers
    @State private var isShowingSwiftSourceExport = false
    @State private var isShowingPlainTextExport = false
    @State private var isShowingXMLExport = false
    @State private var isShowingYAMLExport = false
    @State private var isShowingJSONExport = false
    @State private var isShowingHTMLExport = false
    @State private var isShowingAssemblyExport = false
    @State private var isShowingCHeaderExport = false
    @State private var isShowingCSourceExport = false
    @State private var isShowingCPlusPlusHeaderExport = false
    @State private var isShowingCPlusPlusSourceExport = false
    @State private var isShowingObjectiveCPlusPlusSourceExport = false
    @State private var isShowingObjectiveCSourceExport = false
    @State private var isShowingAppleScriptExport = false
    @State private var isShowingJavaScriptExport = false
    @State private var isShowingShellScriptExport = false
    @State private var isShowingPythonScriptExport = false
    @State private var isShowingRubyScriptExport = false
    @State private var isShowingPerlScriptExport = false
    @State private var isShowingPHPScriptExport = false
    var body: some View {
        NavigationStack {
            //Code Editor View
            CodeView(theme: settings.theme, code: $document.text, mode: settings.syntax.mode(), fontSize: settings.fontSize, showInvisibleCharacters: settings.showInvisibleCharacters, lineWrapping: settings.lineWrapping)
            //On Editor Load Get File Attributes
                .onLoadSuccess {
                    getAttributes()
                }
            //Error If The Editor Fails To Load
                .onLoadFail { error in
                    print("Load Failed: \(error.localizedDescription)")
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
                .toolbarRole(.editor)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle($fileNameAttribute)
                .onChange(of: fileNameAttribute) {
                    if fileNameAttribute != "N/A" {
                        let newName = fileNameAttribute
                        let oldExtension = fileURL.pathExtension
                        let newPath = fileURL.deletingLastPathComponent().appendingPathComponent(newName + "." + oldExtension)
                        do {
                            try FileManager.default.moveItem(atPath: fileURL.path(), toPath: newPath.path())
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                .navigationDocument(fileURL)
            //Toolbar Of Quick Actions
                .toolbar(id: "quick-actions") {
                    ToolbarItem(id: "dismiss-document", placement: .navigation) {
                        Button(action: {dismiss()}) {
                            Label("Back", systemImage: "chevron.left")
                        }
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
                                Label("Light", systemImage: "sun.max")
                            }
                            Button(action: {selectedAppearance = 2}) {
                                Label("Dark", systemImage: "moon")
                            }
                            Button(action: {selectedAppearance = 3}) {
                                Label("System", systemImage: "laptopcomputer")
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
                    ToolbarItem(id: "settings", placement: .secondaryAction) {
                        Button(action: {showingSettings = true}) {
                            Label("Settings", systemImage: "gearshape")
                        }
                        .help("Settings")
                        .keyboardShortcut(",")
                    }
                }
                .sheet(isPresented: $showingSettings) {
                    NavigationStack {
                        SettingsView()
                    }
                }
        }
        .inspector(isPresented: $showingInspector) {
            NavigationStack {
                //Form Showing File Metadata
                Form {
                    Section {
                        Text("\(fileNameAttribute)")
                            .textSelection(.enabled)
                    } header: {
                        Label("Title", systemImage: "textformat")
                    }
                    Section {
                        Text("\(fileExtensionAttribute)")
                            .textSelection(.enabled)
                    } header: {
                        Label("Extension", systemImage: "square.grid.3x1.folder.badge.plus")
                    }
                    Section {
                        Text("\(fileByteCountFormatter.string(fromByteCount: fileSizeAttribute))")
                            .textSelection(.enabled)
                    } header: {
                        Label("Size", systemImage: "externaldrive")
                    }
                    Section {
                        Text("\(filePathAttribute)")
                            .textSelection(.enabled)
                    } header: {
                        Label("Path", systemImage: "point.topleft.down.curvedto.point.bottomright.up")
                    }
                    Section {
                        Text("\(fileOwnerAttribute)")
                            .textSelection(.enabled)
                    } header: {
                        Label("Owner", systemImage: "person")
                    }
                    Section {
                        Text("\(fileCreatedAttribute.formatted(.dateTime))")
                            .textSelection(.enabled)
                    } header: {
                        Label("Created", systemImage: "calendar.badge.plus")
                    }
                    Section {
                        Text("\(fileModifiedAttribute.formatted(.dateTime))")
                            .textSelection(.enabled)
                    } header: {
                        Label("Modified", systemImage: "calendar.badge.clock")
                    }
                    Section {
                        Text("\(fileTypeAttribute)")
                            .textSelection(.enabled)
                    } header: {
                        Label("File Type", systemImage: "doc")
                    } footer: {
                        Text("Metadata Generated From Last Time The File Was Opened")
                    }
                }
                .navigationTitle("Metadata")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {getAttributes()}) {
                            Label("Update Metadata", systemImage: "arrow.counterclockwise")
                        }
                        .help("Update Metadata")
                        .keyboardShortcut("r")
                    }
                }
            }
        }
    }
    //Form Showing Export Options, File Print Button And File Exporters
    var export: some View {
        Form {
            Group {
                Button("Swift") {
                    isShowingSwiftSourceExport.toggle()
                }
                .fileExporter(isPresented: $isShowingSwiftSourceExport, document: document, contentType: .swiftSource, defaultFilename: "Exported Swift File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("Plain Text") {
                    isShowingPlainTextExport.toggle()
                }
                .fileExporter(isPresented: $isShowingPlainTextExport, document: document, contentType: .plainText, defaultFilename: "Exported Text File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("XML") {
                    isShowingXMLExport.toggle()
                }
                .fileExporter(isPresented: $isShowingXMLExport, document: document, contentType: .xml, defaultFilename: "Exported XML File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("YAML") {
                    isShowingYAMLExport.toggle()
                }
                .fileExporter(isPresented: $isShowingYAMLExport, document: document, contentType: .yaml, defaultFilename: "Exported YAML File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("JSON") {
                    isShowingJSONExport.toggle()
                }
                .fileExporter(isPresented: $isShowingJSONExport, document: document, contentType: .json, defaultFilename: "Exported JSON File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("HTML") {
                    isShowingHTMLExport.toggle()
                }
                .fileExporter(isPresented: $isShowingHTMLExport, document: document, contentType: .html, defaultFilename: "Exported HTML File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("Assembly") {
                    isShowingAssemblyExport.toggle()
                }
                .fileExporter(isPresented: $isShowingAssemblyExport, document: document, contentType: .assemblyLanguageSource, defaultFilename: "Exported Assembly File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("C Header") {
                    isShowingCHeaderExport.toggle()
                }
                .fileExporter(isPresented: $isShowingCHeaderExport, document: document, contentType: .cHeader, defaultFilename: "Exported C Header File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("C Source") {
                    isShowingCSourceExport.toggle()
                }
                .fileExporter(isPresented: $isShowingCSourceExport, document: document, contentType: .cSource, defaultFilename: "Exported C Source File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("C++ Header") {
                    isShowingCPlusPlusHeaderExport.toggle()
                }
                .fileExporter(isPresented: $isShowingCPlusPlusHeaderExport, document: document, contentType: .cPlusPlusHeader, defaultFilename: "Exported C++ Header File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            Group {
                Button("C++ Source") {
                    isShowingCPlusPlusSourceExport.toggle()
                }
                .fileExporter(isPresented: $isShowingCPlusPlusSourceExport, document: document, contentType: .cPlusPlusSource, defaultFilename: "Exported C++ Source File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("Objective C++") {
                    isShowingObjectiveCPlusPlusSourceExport.toggle()
                }
                .fileExporter(isPresented: $isShowingObjectiveCPlusPlusSourceExport, document: document, contentType: .objectiveCPlusPlusSource, defaultFilename: "Exported Objective C++ File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("Objective C") {
                    isShowingObjectiveCSourceExport.toggle()
                }
                .fileExporter(isPresented: $isShowingObjectiveCSourceExport, document: document, contentType: .objectiveCSource, defaultFilename: "Exported Objective C File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("AppleScript") {
                    isShowingAppleScriptExport.toggle()
                }
                .fileExporter(isPresented: $isShowingAppleScriptExport, document: document, contentType: .appleScript, defaultFilename: "Exported AppleScript File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("JavaScript") {
                    isShowingJavaScriptExport.toggle()
                }
                .fileExporter(isPresented: $isShowingJavaScriptExport, document: document, contentType: .javaScript, defaultFilename: "Exported JavaScript File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("Shell Script") {
                    isShowingShellScriptExport.toggle()
                }
                .fileExporter(isPresented: $isShowingShellScriptExport, document: document, contentType: .shellScript, defaultFilename: "Exported Shell Script File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("Python") {
                    isShowingPythonScriptExport.toggle()
                }
                .fileExporter(isPresented: $isShowingPythonScriptExport, document: document, contentType: .pythonScript, defaultFilename: "Exported Python File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("Ruby") {
                    isShowingRubyScriptExport.toggle()
                }
                .fileExporter(isPresented: $isShowingRubyScriptExport, document: document, contentType: .rubyScript, defaultFilename: "Exported Ruby File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("Perl") {
                    isShowingPerlScriptExport.toggle()
                }
                .fileExporter(isPresented: $isShowingPerlScriptExport, document: document, contentType: .perlScript, defaultFilename: "Exported Perl File") { result in
                    switch result {
                    case .success(let url):
                        print("Saved To \(url)")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                Button("PHP") {
                    isShowingPHPScriptExport.toggle()
                }
                .fileExporter(isPresented: $isShowingPHPScriptExport, document: document, contentType: .phpScript, defaultFilename: "Exported PHP File") { result in
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
