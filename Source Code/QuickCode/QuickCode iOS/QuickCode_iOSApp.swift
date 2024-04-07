//
//  QuickCode_iOSApp.swift
//  QuickCode iOS
//
//  Created by Mark Howard on 01/04/2024.
//

import SwiftUI
import DocumentKit

@main
struct QuickCode_iOSApp: App {
    var body: some Scene {
        //Create Document Window For Editor
        DocumentGroup(newDocument: QuickCode_iOSDocument()) { file in
            ContentView(document: file.$document, fileURL: file.fileURL!, fileTypeAttribute: "N/A", fileSizeAttribute: 0, fileTitleAtribute: "N/A", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "N/A", fileOwnerAttribute: "N/A", fileNameAttribute: "N/A", filePathAttribute: "N/A")
        }
        .showFileExtensions(true)
    }
}
