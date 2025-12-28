//
//  InsertCSS.swift
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
struct InsertCSS: AppIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "InsertCSSIntent"

    static var title: LocalizedStringResource = "Set Insert Custom CSS on the Web"
    static var description = IntentDescription("Sets the Insert Custom CSS to on or off on the Web.")

    @Parameter(title: "Operation", default: .turn)
    var toggle: IntentTurnEnum?

    @Parameter(title: "State", default: false)
    var state: Bool

    static var parameterSummary: some ParameterSummary {
        When(\.$toggle, .equalTo, .turn) {
            Summary("\(\.$toggle) Insert Custom CSS \(\.$state) on the Web")
        } otherwise: {
            Summary("\(\.$toggle) Insert Custom CSS on the Web")
        }
    }
    
    func perform() async throws -> some IntentResult {
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
        var insertCSS: Bool = userDefaults.bool(forKey: "insertCSS")
        
        switch toggle {
        case .toggle:
            insertCSS.toggle()
        case .turn:
            insertCSS = state
        default:
            break
        }
        
        userDefaults.set(insertCSS, forKey: "insertCSS")
        
        #if !os(visionOS)
        if #available(iOS 18.0, macOS 26, *) {
            ControlCenter.shared.reloadControls(ofKind: "com.tsg0o0.weba11y.CCWidget.insertCSS")
        }
        #endif
        
        return .result()
    }
}

