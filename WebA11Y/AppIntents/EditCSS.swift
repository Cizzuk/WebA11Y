//
//  EditCSS.swift
//  WebA11Y
//
//  Created by Cizzuk on 2024/09/08.
//

import AppIntents
import Foundation

@available(iOS 16.0, macOS 13.0, visionOS 1.0, *)
struct EditCSS: AppIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "EditCSSIntent"

    static var title: LocalizedStringResource = "Edit Custom CSS to be used on the Web"
    static var description = IntentDescription("Sets the custom CSS to be used on the Web.")

    @Parameter(title: "Custom CSS", default: "")
    var editCSS: String?

    static var parameterSummary: some ParameterSummary {
        Summary("Set custom CSS on the web to \(\.$editCSS)")
    }

    func perform() async throws -> some IntentResult {
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!

        if userDefaults.bool(forKey: "disableEditCustomCSSFromShortcuts") {
            throw IntentError.notAllowedEditingFromShortcut
        }

        userDefaults.set(editCSS, forKey: "customCSS")
        return .result()
    }
}
