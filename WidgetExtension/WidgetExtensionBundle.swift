//
//  WidgetExtensionBundle.swift
//  WebA11Y Widget Extension
//
//  Created by Cizzuk on 2025/12/16.
//

import SwiftUI
import WidgetKit

@main
struct WidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        CCBoldText()
        CCButtonShape()
        CCBlockAnimations()
        CCFontChange()
        CCInsertCSS()
    }
}
