//
//  QuickCodeDocument.swift
//  QuickCode
//
//  Created by Mark Howard on 01/04/2024.
//

import SwiftUI
import UniformTypeIdentifiers

//Get Custom Type For Document Creation
extension UTType {
    static var quickcodeText: UTType {
        UTType(importedAs: "com.MSJ.QuickCode.text")
    }
}

struct QuickCodeDocument: FileDocument {
    var text: String

    //Set Text As Blank When Creating A New Document
    init(text: String = "") {
        self.text = text
    }

    //Set Readable File Types
    static var readableContentTypes: [UTType] { [.quickcodeText, .assemblyLanguageSource, .cHeader, .cSource, .cPlusPlusHeader, .cPlusPlusSource, .objectiveCPlusPlusSource, .objectiveCSource, .swiftSource, .delimitedText, .commaSeparatedText, .tabSeparatedText, .utf8TabSeparatedText, .xml, .yaml, .json, .html, .propertyList, .xmlPropertyList, .binaryPropertyList, .script, .appleScript, .javaScript, .osaScript, .osaScriptBundle, .makefile, .shellScript, .pythonScript, .rubyScript, .perlScript, .phpScript, .text, .plainText, .utf8PlainText, .utf16PlainText, .utf16ExternalPlainText, .data, .sourceCode] }

    //Set How To Read Documents
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    //Set How To Write Documents
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
