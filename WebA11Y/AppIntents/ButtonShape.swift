//
//  ButtonShape.swift
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
struct ButtonShape: AppIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "ButtonShapeIntent"

    static var title: LocalizedStringResource = "Set Button Shape on the Web"
    static var description = IntentDescription("Sets the Button Shape to on or off on the Web.")

    @Parameter(title: "Operation", default: .turn)
    var toggle: IntentTurnEnum?

    @Parameter(title: "State", default: false)
    var state: Bool

    static var parameterSummary: some ParameterSummary {
        When(\.$toggle, .equalTo, .turn) {
            Summary("\(\.$toggle) Button Shape \(\.$state) on the Web")
        } otherwise: {
            Summary("\(\.$toggle) Button Shape on the Web")
        }
    }
    
    func perform() async throws -> some IntentResult {
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
        var buttonShape: Bool = userDefaults.bool(forKey: "buttonShape")
        
        switch toggle {
        case .toggle:
            buttonShape.toggle()
        case .turn:
            buttonShape = state
        default:
            break
        }
        
        userDefaults.set(buttonShape, forKey: "buttonShape")
        
        #if !os(visionOS)
        if #available(iOS 18.0, macOS 26, *) {
            ControlCenter.shared.reloadControls(ofKind: "com.tsg0o0.weba11y.CCWidget.buttonShape")
        }
        #endif
        
        return .result()
    }
}

