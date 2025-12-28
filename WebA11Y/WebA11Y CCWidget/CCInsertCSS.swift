//
//  CCInsertCSS.swift
//  WebA11Y
//
//  Created by Cizzuk on 2025/12/16.
//

import AppIntents
import SwiftUI
import WidgetKit

struct CCInsertCSS: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: "com.tsg0o0.weba11y.CCWidget.insertCSS",
            provider: Provider()
        ) { value in
            ControlWidgetToggle(
                "Custom CSS",
                isOn: value,
                action: CCInsertCSSIntent()
            ) { isRunning in
                Label(isRunning ? "On" : "Off", systemImage: "curlybraces")
            }
        }
        .displayName("Custom CSS")
    }
}

extension CCInsertCSS {
    struct Provider: ControlValueProvider {
        var previewValue: Bool { false }
        func currentValue() async throws -> Bool {
            let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
            return userDefaults.bool(forKey: "insertCSS")
        }
    }
}

struct CCInsertCSSIntent: SetValueIntent {
    static let title: LocalizedStringResource = "Insert CSS"
    static var isDiscoverable: Bool = false

    @Parameter(title: "Custom CSS", default: false)
    var value: Bool

    func perform() async throws -> some IntentResult {
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
        userDefaults.set(value, forKey: "insertCSS")
        return .result()
    }
}
