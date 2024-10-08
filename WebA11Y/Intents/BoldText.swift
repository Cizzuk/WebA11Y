//
//  BoldText.swift
//  WebA11Y
//
//  Created by Cizzuk on 8/31/24.
//

import Foundation
import AppIntents

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
enum BoldTextEnum: String, AppEnum {
    case turn
    case toggle

    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Int-Toggle")
    static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .turn: "Int-Turn",
        .toggle: "Int-Toggle"
    ]
}

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct BoldText: AppIntent, CustomIntentMigratedAppIntent, PredictableIntent {
    static let intentClassName = "BoldTextIntent"

    static var title: LocalizedStringResource = "Set Bold Text on the Web"
    static var description = IntentDescription("Sets the Bold Text to on or off on the Web.")

    @Parameter(title: "Int-ToggleTitle", default: .turn)
    var toggle: BoldTextEnum?

    @Parameter(title: "Int-State", default: false)
    var state: Bool?

    static var parameterSummary: some ParameterSummary {
        When(\.$toggle, .equalTo, .turn) {
            Summary("\(\.$toggle) Bold Text \(\.$state) on the Web")
        } otherwise: {
            Summary("\(\.$toggle) Bold Text on the Web")
        }
    }

    static var predictionConfiguration: some IntentPredictionConfiguration {
        IntentPrediction(parameters: (\.$state, \.$toggle)) { state, toggle in
            DisplayRepresentation(
                title: "\(toggle!) Bold Text \(state! ? "On":"Off") on the Web"
            )
        }
        IntentPrediction(parameters: (\.$toggle)) { toggle in
            DisplayRepresentation(
                title: "\(toggle!) Bold Text on the Web"
            )
        }
    }
    
    func perform() async throws -> some IntentResult {
        // TODO: Place your refactored intent handler code here.
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")
        
        if toggle == .turn {
            if state == true {
                userDefaults!.set("true", forKey: "boldText")
            } else if state == false {
                userDefaults!.set("false", forKey: "boldText")
            }
        } else if toggle == .toggle {
            let boldText = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!.bool(forKey: "boldText")
            if boldText == false {
                userDefaults!.set("true", forKey: "boldText")
            } else {
                userDefaults!.set("false", forKey: "boldText")
            }
        }
        userDefaults!.synchronize()
        return .result()
    }
}

