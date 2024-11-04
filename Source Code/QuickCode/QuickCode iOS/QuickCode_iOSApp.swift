//
//  QuickCode_iOSApp.swift
//  QuickCode iOS
//
//  Created by Mark Howard on 01/04/2024.
//

import SwiftUI

@main
struct QuickCode_iOSAppLauncher {
    static func main() {
        if #available(iOS 18.0, *) {
            QuickCode_iOSApp18.main()
        } else {
            QuickCode_iOSApp.main()
        }
    }
}

struct QuickCode_iOSApp: App {
    var body: some Scene {
        //Create Document Window For Editor
        DocumentGroup(newDocument: QuickCode_iOSDocument()) { file in
            ContentView(document: file.$document, fileURL: file.fileURL!, fileTypeAttribute: "N/A", fileSizeAttribute: 0, fileTitleAtribute: "N/A", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "N/A", fileOwnerAttribute: "N/A", fileNameAttribute: "N/A", filePathAttribute: "N/A")
        }
    }
}

@available(iOS 18.0, *)
struct QuickCode_iOSApp18: App {
    var body: some Scene {
        //Create Document Window For Editor
        DocumentGroup(newDocument: QuickCode_iOSDocument()) { file in
            ContentView(document: file.$document, fileURL: file.fileURL!, fileTypeAttribute: "N/A", fileSizeAttribute: 0, fileTitleAtribute: "N/A", fileCreatedAttribute: Date(), fileModifiedAttribute: Date(), fileExtensionAttribute: "N/A", fileOwnerAttribute: "N/A", fileNameAttribute: "N/A", filePathAttribute: "N/A")
        }
        DocumentGroupLaunchScene {
            NewDocumentButton("New Document")
        } background: {
            LinearGradient(colors: [.accentColor, .mint], startPoint: .bottom, endPoint: .top)
        }
    }
}
