//
//  CCBoldText.swift
//  WebA11Y
//
//  Created by Cizzuk on 2025/12/16.
//

import AppIntents
import SwiftUI
import WidgetKit

struct CCFontChange: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: "com.tsg0o0.weba11y.CCWidget.fontChange",
            provider: Provider()
        ) { value in
            ControlWidgetToggle(
                "Font Change",
                isOn: value,
                action: CCFontChangeIntent()
            ) { isRunning in
                Label(isRunning ? "On" : "Off", systemImage: "textformat.characters")
            }
        }
        .displayName("Font Change")
    }
}

extension CCFontChange {
    struct Provider: ControlValueProvider {
        var previewValue: Bool { false }
        func currentValue() async throws -> Bool {
            let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
            return userDefaults.bool(forKey: "fontChange")
        }
    }
}

struct CCFontChangeIntent: SetValueIntent {
    static let title: LocalizedStringResource = "Font Change"
    static var isDiscoverable: Bool = false

    @Parameter(title: "Font Change", default: false)
    var value: Bool

    func perform() async throws -> some IntentResult {
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
        userDefaults.set(value, forKey: "fontChange")
        return .result()
    }
}
