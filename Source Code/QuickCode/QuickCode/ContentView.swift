//
//  ContentView.swift
//  QuickCode
//
//  Created by Mark Howard on 01/04/2024.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: QuickCodeDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(QuickCodeDocument()))
}
