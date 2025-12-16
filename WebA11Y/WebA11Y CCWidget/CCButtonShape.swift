//
//  CCBoldText.swift
//  WebA11Y
//
//  Created by Cizzuk on 2025/12/16.
//

import AppIntents
import SwiftUI
import WidgetKit

struct CCButtonShape: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: "com.tsg0o0.weba11y.CCWidget.buttonShape",
            provider: Provider()
        ) { value in
            ControlWidgetToggle(
                "buttonShape",
                isOn: value,
                action: CCButtonShapeIntent()
            ) { isRunning in
                Label(isRunning ? "On" : "Off", systemImage: "underline")
            }
        }
        .displayName("buttonShape")
    }
}

extension CCButtonShape {
    struct Provider: ControlValueProvider {
        var previewValue: Bool { false }
        func currentValue() async throws -> Bool {
            let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
            return userDefaults.bool(forKey: "buttonShape")
        }
    }
}

struct CCButtonShapeIntent: SetValueIntent {
    static let title: LocalizedStringResource = "buttonShape"
    static var isDiscoverable: Bool = false

    @Parameter(title: "buttonShape", default: false)
    var value: Bool

    func perform() async throws -> some IntentResult {
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
        userDefaults.set(value, forKey: "buttonShape")
        return .result()
    }
}
