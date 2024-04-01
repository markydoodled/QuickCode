//
//  QuickCodeApp.swift
//  QuickCode
//
//  Created by Mark Howard on 01/04/2024.
//

import SwiftUI

@main
struct QuickCodeApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: QuickCodeDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
