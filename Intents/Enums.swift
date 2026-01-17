//
//  Enums.swift
//  WebA11Y
//
//  Created by Cizzuk on 2025/01/29.
//

import Foundation
import AppIntents

@available(iOS 16.0, macOS 13.0, visionOS 1.0, *)
enum IntentTurnEnum: String, AppEnum {
    case turn
    case toggle

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Operation")
    static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .turn: "Turn",
        .toggle: "Toggle"
    ]
}
