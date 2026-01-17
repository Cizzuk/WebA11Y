//
//  BlockAnimations.swift
//  WebA11Y
//
//  Created by Cizzuk on 2026/01/17.
//

import Foundation
import AppIntents
#if !os(visionOS)
import WidgetKit
#endif

@available(iOS 16.0, macOS 13.0, visionOS 1.0, *)
struct BlockAnimations: AppIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "BlockAnimationsIntent"

    static var title: LocalizedStringResource = "Set Block Animations on the Web"
    static var description = IntentDescription("Sets the Block Animations to on or off on the Web.")

    @Parameter(title: "Operation", default: .turn)
    var toggle: IntentTurnEnum?

    @Parameter(title: "State", default: false)
    var state: Bool

    static var parameterSummary: some ParameterSummary {
        When(\.$toggle, .equalTo, .turn) {
            Summary("\(\.$toggle) Block Animations \(\.$state) on the Web")
        } otherwise: {
            Summary("\(\.$toggle) Block Animations on the Web")
        }
    }
    
    func perform() async throws -> some IntentResult {
        let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
        var blockAnimations: Bool = userDefaults.bool(forKey: "blockAnimations")
        
        switch toggle {
        case .toggle:
            blockAnimations.toggle()
        case .turn:
            blockAnimations = state
        default:
            break
        }
        
        userDefaults.set(blockAnimations, forKey: "blockAnimations")
        
        #if !os(visionOS)
        if #available(iOS 18.0, macOS 26, *) {
            ControlCenter.shared.reloadControls(ofKind: "com.tsg0o0.weba11y.CCWidget.blockAnimations")
        }
        #endif
        
        return .result()
    }
}

