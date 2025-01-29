//
//  BoldText.swift
//  WebA11Y
//
//  Created by Cizzuk on 2024/08/31.
//

import Foundation
import AppIntents

@available(iOS 16.0, macOS 13.0, visionOS 1.0, *)
struct BoldText: AppIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "BoldTextIntent"

    static var title: LocalizedStringResource = "Set Bold Text on the Web"
    static var description = IntentDescription("Sets the Bold Text to on or off on the Web.")

    @Parameter(title: "Operation", default: .turn)
    var toggle: IntentTurnEnum?

    @Parameter(title: "State", default: false)
    var state: Bool

    static var parameterSummary: some ParameterSummary {
        When(\.$toggle, .equalTo, .turn) {
            Summary("\(\.$toggle) Bold Text \(\.$state) on the Web")
        } otherwise: {
            Summary("\(\.$toggle) Bold Text on the Web")
        }
    }
    
    func perform() async throws -> some IntentResult {
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
        var boldText: Bool = userDefaults.bool(forKey: "boldText")
        
        switch toggle {
        case .toggle:
            boldText.toggle()
        case .turn:
            boldText = state
        default:
            break
        }
        
        userDefaults.set(boldText, forKey: "boldText")
        
        return .result()
    }
}

