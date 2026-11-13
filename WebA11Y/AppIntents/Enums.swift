//
//  Enums.swift
//  WebA11Y
//
//  Created by Cizzuk on 2025/01/29.
//

import AppIntents
import Foundation
import SwiftUI

@available(iOS 16.0, macOS 13.0, visionOS 1.0, *)
enum IntentTurnEnum: String, AppEnum {
    case turn
    case toggle

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Operation")
    static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .turn: "Turn",
        .toggle: "Toggle",
    ]
}

@available(iOS 16.0, macOS 13.0, visionOS 1.0, *)
enum IntentError: Error, CustomLocalizedStringResourceConvertible {
    case notAllowedEditingFromShortcut

    var localizedStringResource: LocalizedStringResource {
        switch self {
        case .notAllowedEditingFromShortcut:
            return "Editing this setting from Shortcuts is not allowed in WebA11Y settings."
        }
    }
}
