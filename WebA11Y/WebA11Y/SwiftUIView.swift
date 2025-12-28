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
    @AppStorage("insertCSS", store: userDefaults) var insertCSS: Bool = false
    
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
                
                // Bold Text
                Section {
                    Toggle(isOn: $boldText) {
                        IconLabel(icon: "bold", text: "Bold Text")
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
                        Text("Boldens all text.")
                        Text("It does not apply to some texts, such as those that are already bold.")
                    }
                }
                
                // Button Shape
                Section {
                    Toggle(isOn: $buttonShape) {
                        IconLabel(icon: "underline", text: "Button Shape")
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
                        Text("Underlines links and buttons.")
                        Text("It does not apply to non-text buttons.")
                    }
                }
                
                // Font Change
                Section {
                    Toggle(isOn: $fontChange) {
                        IconLabel(icon: "textformat", text: "Font Change")
                    }
                    .onChange(of: fontChange) { _ in
                        #if !os(visionOS)
                        if #available(iOS 18.0, macOS 26, *) {
                            ControlCenter.shared.reloadControls(ofKind: "com.tsg0o0.weba11y.CCWidget.fontChange")
                        }
                        #endif
                    }
                    if fontChange {
                        TextField("sans-serif", text: $fontFamily)
                            .textInputAutocapitalization(.never)
                            .submitLabel(.done)
                            .accessibilityTextContentType(.sourceCode)
                    }
                } footer: {
                    VStack (alignment : .leading) {
                        Text("Change the font.")
                        Text("Icons will not display correctly on some websites.")
                        if fontChange {
                            Spacer()
                            Text("Font example:")
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
                }
                
                // Custom CSS
                Section {
                    NavigationLink(destination: CustomCSSView()) {
                        HStack {
                            IconLabel(icon: "curlybraces", text: "Custom CSS")
                            Spacer()
                            Text(insertCSS ? "On" : "Off")
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                } footer: {
                    Text("Insert custom styles into pages.")
                }
                
                // Support Section
                Section {
                    NavigationLink(destination: AboutView()) {
                        Text("About")
                    }
                }
            }
            .animation(.default, value: fontChange)
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
