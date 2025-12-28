//
//  CustomCSS.swift
//  WebA11Y
//
//  Created by Cizzuk on 2025/12/28.
//

import SwiftUI
#if !os(visionOS)
import WidgetKit
#endif

struct CustomCSSView: View {
    @AppStorage("insertCSS", store: userDefaults) var insertCSS: Bool = false
    @AppStorage("customCSS", store: userDefaults) var customCSS: String = """
        * {
            font: medium/1.5 system-ui, sans-serif !important;
        }
        """

    var body: some View {
        List {
            Section {
                Toggle(isOn: $insertCSS) {
                    IconLabel(icon: "curlybraces", text: "Custom CSS")
                }
                .onChange(of: insertCSS) { _ in
                    #if !os(visionOS)
                    if #available(iOS 18.0, macOS 26, *) {
                        ControlCenter.shared.reloadControls(ofKind: "com.tsg0o0.weba11y.CCWidget.insertCSS")
                    }
                    #endif
                }
            }
            
            if insertCSS {
                Section {
                    TextEditor(text: $customCSS)
                        .frame(minHeight: 200)
                        .font(.system(.body, design: .monospaced))
                        .textInputAutocapitalization(.never)
                        .submitLabel(.return)
                        .accessibilityTextContentType(.sourceCode)
                } footer: {
                    VStack (alignment : .leading) {
                        Text("Please make sure that the entered style is correct.")
                        Spacer()
                        Text("For CSS, please refer to the following page:")
                        Link("https://developer.mozilla.org/en-US/docs/Web/CSS", destination: URL(string: "https://developer.mozilla.org/en-US/docs/Web/CSS")!)
                    }
                    .font(.caption)
                }
            }
        }
        .animation(.default, value: insertCSS)
        .navigationTitle("Custom CSS")
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
