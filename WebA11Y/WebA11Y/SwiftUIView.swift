//
//  SwiftUIView.swift
//  WebA11Y
//
//  Created by Cizzuk on 2024/03/23.
//

import SwiftUI
#if !os(visionOS)
import WidgetKit
#endif

@main
struct MainView: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    // Load app settings
    @AppStorage("boldText", store: userDefaults) var boldText: Bool = false
    @AppStorage("buttonShape", store: userDefaults) var buttonShape: Bool = false
    @AppStorage("fontChange", store: userDefaults) var fontChange: Bool = false
    @AppStorage("fontFamily", store: userDefaults) var fontFamily: String = "sans-serif"
    
    var body: some View {
        NavigationView {
            List {
                Section {} footer: {
                    #if targetEnvironment(macCatalyst)
                        Text("Open Safari, go to Safari → Settings..., select 'Extensions' tab and enable WebA11Y.")
                    #else
                        Text("Go to Settings → Apps → Safari → Extensions → WebA11Y and allow extension.")
                    #endif
                }
                
                Section {
                    Toggle(isOn: $boldText) {
                        Text("boldText")
                            .bold()
                    }
                    .onChange(of: boldText) { _ in
                        #if !os(visionOS)
                        if #available(iOS 18.0, macOS 26, *) {
                            ControlCenter.shared.reloadControls(ofKind: "com.tsg0o0.weba11y.CCWidget.boldText")
                        }
                        #endif
                    }
                } footer: {
                    VStack (alignment : .leading) {
                        Text("boldText-Desc-1")
                        Text("boldText-Desc-2")
                    }
                }
                Section {
                    Toggle(isOn: $buttonShape) {
                        Text("buttonShape")
                            .underline()
                    }
                    .onChange(of: buttonShape) { _ in
                        #if !os(visionOS)
                        if #available(iOS 18.0, macOS 26, *) {
                            ControlCenter.shared.reloadControls(ofKind: "com.tsg0o0.weba11y.CCWidget.buttonShape")
                        }
                        #endif
                    }
                } footer: {
                    VStack (alignment : .leading) {
                        Text("buttonShape-Desc-1")
                        Text("buttonShape-Desc-2")
                    }
                }
                Section {
                    Toggle(isOn: $fontChange) {
                        Text("fontChange")
                            .font(.system(.body, design: .serif))
                    }
                    .onChange(of: fontChange) { _ in
                        #if !os(visionOS)
                        if #available(iOS 18.0, macOS 26, *) {
                            ControlCenter.shared.reloadControls(ofKind: "com.tsg0o0.weba11y.CCWidget.fontChange")
                        }
                        #endif
                    }
                    TextField("sans-serif", text: $fontFamily)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.done)
                        .accessibilityTextContentType(.sourceCode)
                } footer: {
                    VStack (alignment : .leading) {
                        Text("fontChange-Desc-1")
                        Text("fontChange-Desc-2")
                        Spacer()
                        Text("fontChange-Desc-3")
                        Text("sans-serif: ABC 123 inm")
                            .font(.system(.caption, design: .default))
                            .bold()
                            .accessibilityLabel("sans-serif")
                            .accessibilityTextContentType(.sourceCode)
                        Text("serif: ABC 123 inm")
                            .font(.system(.caption, design: .serif))
                            .bold()
                            .accessibilityLabel("serif")
                            .accessibilityTextContentType(.sourceCode)
                        Text("monospace: ABC 123 inm")
                            .font(.system(.caption, design: .monospaced))
                            .bold()
                            .accessibilityLabel("monospace")
                            .accessibilityTextContentType(.sourceCode)
                    }
                }
                
                // Support Section
                Section {
                    NavigationLink(destination: AboutView()) {
                        Text("About")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("WebA11Y")
        }
        .navigationViewStyle(.stack)
    }
}

struct IconLabel: View {
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    let icon: String
    let text: String.LocalizationValue
    
    var body: some View {
        HStack {
            if dynamicTypeSize <= .xxxLarge {
                Image(systemName: icon)
                    .frame(width: 20.0, alignment: .center)
                Spacer().frame(width: 10.0)
            }
            Text(String(localized: text))
        }
    }
}
