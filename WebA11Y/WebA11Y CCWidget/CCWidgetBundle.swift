//
//  CCWidgetBundle.swift
//  WebA11Y CCWidget
//
//  Created by Cizzuk on 2025/12/16.
//

import WidgetKit
import SwiftUI

@main
struct CCWidgetBundle: WidgetBundle {
    var body: some Widget {
        CCBoldText()
        CCButtonShape()
        CCFontChange()
        CCInsertCSS()
    }
}
