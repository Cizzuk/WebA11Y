//
//  FontChange.swift
//  WebA11Y
//
//  Created by Cizzuk on 8/31/24.
//

import Foundation
import AppIntents

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
enum FontChangeEnum: String, AppEnum {
    case turn
    case toggle

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Int-Toggle")
    static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .turn: "Int-Turn",
        .toggle: "Int-Toggle"
    ]
}

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct FontChange: AppIntent, CustomIntentMigratedAppIntent, PredictableIntent {
    static let intentClassName = "FontChangeIntent"

    static var title: LocalizedStringResource = "Set Font Change on the Web"
    static var description = IntentDescription("Sets the Font Change to on or off on the Web.")

    @Parameter(title: "Int-ToggleTitle", default: .turn)
    var toggle: FontChangeEnum?

    @Parameter(title: "Int-State", default: false)
    var state: Bool?

    static var parameterSummary: some ParameterSummary {
        When(\.$toggle, .equalTo, .turn) {
            Summary("\(\.$toggle) Font Change \(\.$state) on the Web")
        } otherwise: {
            Summary("\(\.$toggle) Font Change on the Web")
        }
    }

    static var predictionConfiguration: some IntentPredictionConfiguration {
        IntentPrediction(parameters: (\.$state, \.$toggle)) { state, toggle in
            DisplayRepresentation(
                title: "\(toggle!) Font Change \(state! ? "On":"Off") on the Web"
            )
        }
        IntentPrediction(parameters: (\.$toggle)) { toggle in
            DisplayRepresentation(
                title: "\(toggle!) Font Change on the Web"
            )
        }
    }
    
    func perform() async throws -> some IntentResult {
        // TODO: Place your refactored intent handler code here.
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")
        
        if toggle == .turn {
            if state == true {
                userDefaults!.set("true", forKey: "fontChange")
            } else if state == false {
                userDefaults!.set("false", forKey: "fontChange")
            }
        } else if toggle == .toggle {
            let boldText = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!.bool(forKey: "fontChange")
            if boldText == false {
                userDefaults!.set("true", forKey: "fontChange")
            } else {
                userDefaults!.set("false", forKey: "fontChange")
            }
        }
        userDefaults!.synchronize()
        return .result()
    }
}

