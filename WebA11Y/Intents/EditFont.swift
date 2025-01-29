//
//  EditFont.swift
//  WebA11Y
//
//  Created by Cizzuk on 2024/09/08.
//

import Foundation
import AppIntents

@available(iOS 16.0, macOS 13.0, visionOS 1.0, *)
struct EditFont: AppIntent, CustomIntentMigratedAppIntent, PredictableIntent {
    static let intentClassName = "EditFontIntent"

    static var title: LocalizedStringResource = "Edit Font to be used on the Web"
    static var description = IntentDescription("Sets the font name to be used on the Web.")

    @Parameter(title: "Int-fontFamily", default: "sans-serif")
    var fontFamily: String?

    static var parameterSummary: some ParameterSummary {
        Summary("Set font on the web to \(\.$fontFamily)")
    }

    static var predictionConfiguration: some IntentPredictionConfiguration {
        IntentPrediction(parameters: (\.$fontFamily)) { fontFamily in
            DisplayRepresentation(
                title: "Set font on the web to \(fontFamily!)"
            )
        }
    }

    func perform() async throws -> some IntentResult {
        // TODO: Place your refactored intent handler code here.
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")
        userDefaults!.set(fontFamily, forKey: "fontFamily")
        userDefaults!.synchronize()
        return .result()
    }
}

