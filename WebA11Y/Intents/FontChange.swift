//
//  FontChange.swift
//  WebA11Y
//
//  Created by Cizzuk on 2024/08/31.
//

import Foundation
import AppIntents
#if !os(visionOS)
import WidgetKit
#endif

@available(iOS 16.0, macOS 13.0, visionOS 1.0, *)
struct FontChange: AppIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "FontChangeIntent"

    static var title: LocalizedStringResource = "Set Font Change on the Web"
    static var description = IntentDescription("Sets the Font Change to on or off on the Web.")

    @Parameter(title: "Operation", default: .turn)
    var toggle: IntentTurnEnum?

    @Parameter(title: "State", default: false)
    var state: Bool

    static var parameterSummary: some ParameterSummary {
        When(\.$toggle, .equalTo, .turn) {
            Summary("\(\.$toggle) Font Change \(\.$state) on the Web")
        } otherwise: {
            Summary("\(\.$toggle) Font Change on the Web")
        }
    }
    
    func perform() async throws -> some IntentResult {
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
        var fontChange: Bool = userDefaults.bool(forKey: "fontChange")
        
        switch toggle {
        case .toggle:
            fontChange.toggle()
        case .turn:
            fontChange = state
        default:
            break
        }
        
        userDefaults.set(fontChange, forKey: "fontChange")
        
        #if !os(visionOS)
        if #available(iOS 18.0, macOS 26, *) {
            ControlCenter.shared.reloadControls(ofKind: "com.tsg0o0.weba11y.CCWidget.fontChange")
        }
        #endif
        
        return .result()
    }
}

