//
//  QuickCode_iOSApp.swift
//  QuickCode iOS
//
//  Created by Mark Howard on 01/04/2024.
//

import SwiftUI

@main
struct QuickCode_iOSApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: QuickCode_iOSDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
