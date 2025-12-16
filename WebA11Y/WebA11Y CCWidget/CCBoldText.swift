//
//  CCBoldText.swift
//  WebA11Y
//
//  Created by Cizzuk on 2025/12/16.
//

import AppIntents
import SwiftUI
import WidgetKit

struct CCBoldText: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: "com.tsg0o0.weba11y.CCWidget.boldText",
            provider: Provider()
        ) { value in
            ControlWidgetToggle(
                "boldText",
                isOn: value,
                action: CCBoldTextIntent()
            ) { isRunning in
                Label(isRunning ? "On" : "Off", systemImage: "bold")
            }
        }
        .displayName("boldText")
    }
}

extension CCBoldText {
    struct Provider: ControlValueProvider {
        var previewValue: Bool { false }
        func currentValue() async throws -> Bool {
            let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
            return userDefaults.bool(forKey: "boldText")
        }
    }
}

struct CCBoldTextIntent: SetValueIntent {
    static let title: LocalizedStringResource = "boldText"
    static var isDiscoverable: Bool = false

    @Parameter(title: "boldText", default: false)
    var value: Bool

    func perform() async throws -> some IntentResult {
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
        userDefaults.set(value, forKey: "boldText")
        return .result()
    }
}
