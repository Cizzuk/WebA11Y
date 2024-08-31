//
//  BoldText.swift
//  WebA11Y
//
//  Created by Cizzuk on 8/31/24.
//

import Foundation
import AppIntents

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct BoldText: AppIntent, CustomIntentMigratedAppIntent, PredictableIntent {
    static let intentClassName = "BoldTextIntent"

    static var title: LocalizedStringResource = "Bold Text on the Web"
    static var description = IntentDescription("Change Bold Text setting")

    @Parameter(title: "Toggle", default: .turn)
    var toggle: EnumAppEnum?

    @Parameter(title: "Setting", default: false)
    var setting: Bool?

    static var parameterSummary: some ParameterSummary {
        When(\.$toggle, .equalTo, .turn) {
            Summary("\(\.$toggle) Bold Text \(\.$setting) on the Web")
        } otherwise: {
            Summary("\(\.$toggle) Bold Text on the Web")
        }
    }

    static var predictionConfiguration: some IntentPredictionConfiguration {
        IntentPrediction(parameters: (\.$setting, \.$toggle)) { setting, toggle in
            DisplayRepresentation(
                title: "\(toggle!) Bold Text \(setting! ? "On":"Off") on the Web",
                subtitle: ""
            )
        }
        IntentPrediction(parameters: (\.$toggle)) { toggle in
            DisplayRepresentation(
                title: "\(toggle!) Bold Text on the Web",
                subtitle: ""
            )
        }
        IntentPrediction(parameters: (\.$setting)) { setting in
            DisplayRepresentation(
                title: "Turn Bold Text ",
                subtitle: ""
            )
        }
    }

    func perform() async throws -> some IntentResult {
        // TODO: Place your refactored intent handler code here.
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")
        let boldText = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!.bool(forKey: "boldText")
        
        if toggle == .turn {
            if setting == true {
                userDefaults!.set("true", forKey: "boldText")
            } else if setting == false {
                userDefaults!.set("false", forKey: "boldText")
            }
        } else if toggle == .toggle {
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

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
fileprivate extension IntentDialog {
    static func toggleParameterDisambiguationIntro(count: Int, toggle: EnumAppEnum) -> Self {
        "There are \(count) options matching ‘\(toggle)’."
    }
    static func toggleParameterConfirmation(toggle: EnumAppEnum) -> Self {
        "Just to confirm, you wanted ‘\(toggle)’?"
    }
    static var settingParameterPrompt: Self {
        "Would you like to turn the setting on or off?"
    }
    static func settingParameterDisambiguationIntro(count: Int, setting: Bool) -> Self {
        "There are \(count) options matching ‘\(setting ? "On":"Off")’."
    }
    static func settingParameterConfirmation(setting: Bool) -> Self {
        "Just to confirm, you wanted ‘\(setting ? "On":"Off")’?"
    }
}

