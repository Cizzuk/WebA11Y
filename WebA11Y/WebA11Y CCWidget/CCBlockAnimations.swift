//
//  BlockAnimations.swift
//  WebA11Y
//
//  Created by Cizzuk on 2026/01/17.
//

import AppIntents
import SwiftUI
import WidgetKit

struct CCBlockAnimations: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: "com.tsg0o0.weba11y.CCWidget.blockAnimations",
            provider: Provider()
        ) { value in
            ControlWidgetToggle(
                "Block Animations",
                isOn: value,
                action: CCBlockAnimationsIntent()
            ) { isRunning in
                Label(isRunning ? "On" : "Off", systemImage: "circle.dotted.and.circle")
            }
        }
        .displayName("Block Animations")
    }
}

extension CCBlockAnimations {
    struct Provider: ControlValueProvider {
        var previewValue: Bool { false }
        func currentValue() async throws -> Bool {
            let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
            return userDefaults.bool(forKey: "blockAnimations")
        }
    }
}

struct CCBlockAnimationsIntent: SetValueIntent {
    static let title: LocalizedStringResource = "Block Animations"
    static var isDiscoverable: Bool = false

    @Parameter(title: "Block Animations", default: false)
    var value: Bool

    func perform() async throws -> some IntentResult {
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
        userDefaults.set(value, forKey: "blockAnimations")
        return .result()
    }
}
