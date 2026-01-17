//
//  CustomFontView.swift
//  WebA11Y
//
//  Created by Cizzuk on 2026/01/17.
//

import SwiftUI
#if !os(visionOS)
import WidgetKit
#endif

struct CustomFontView: View {
    @AppStorage("fontChange", store: userDefaults) var fontChange: Bool = false
    @AppStorage("fontFamily", store: userDefaults) var fontFamily: String = "system-ui, sans-serif"

    var body: some View {
        List {
            Section {
                Toggle(isOn: $fontChange) {
                    IconLabel(icon: "textformat", text: "Custom Font")
                }
                .onChange(of: fontChange) { _ in
                    #if !os(visionOS)
                    if #available(iOS 18.0, macOS 26, *) {
                        ControlCenter.shared.reloadControls(ofKind: "com.tsg0o0.weba11y.CCWidget.fontChange")
                    }
                    #endif
                }
            }
            
            if fontChange {
                Section {
                    TextField("system-ui, sans-serif", text: $fontFamily)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.done)
                        .accessibilityTextContentType(.sourceCode)
                } footer: {
                    VStack (alignment : .leading) {
                        Text("Enter the names of fonts available in Safari.")
                        Spacer()
                        Text("Font example:")
                        Group {
                            Text("sans-serif: ABC 123 inm")
                                .font(.system(.caption, design: .default))
                                .bold()
                                .accessibilityLabel("sans-serif")
                            Text("serif: ABC 123 inm")
                                .font(.system(.caption, design: .serif))
                                .bold()
                                .accessibilityLabel("serif")
                            Text("monospace: ABC 123 inm")
                                .font(.system(.caption, design: .monospaced))
                                .bold()
                                .accessibilityLabel("monospace")
                        }
                        .accessibilityTextContentType(.sourceCode)
                    }
                }
            }
        }
        .animation(.default, value: fontChange)
        .navigationTitle("Custom Font")
        .navigationBarTitleDisplayMode(.inline)
        #if !os(visionOS)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Label("Done", systemImage: "checkmark")
                }
            }
        }
        #endif
    }
}

