//
//  SwiftUIView.swift
//  WebA11Y
//
//  Created by Cizzuk on 2024/03/23.
//

import SwiftUI

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
                    if ProcessInfo.processInfo.isMacCatalystApp {
                        Text("Open Safari, go to Safari → Settings..., select 'Extensions' tab and enable WebA11Y.")
                    } else {
                        Text("Go to Settings → Apps → Safari → Extensions → WebA11Y and allow extension.")
                    }
                }
                
                Section {
                    Toggle(isOn: $boldText) {
                        Text("boldText")
                            .bold()
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
                    // Contact Link
                    Link(destination:URL(string: "https://cizzuk.net/contact/")!, label: {
                        IconLabel(icon: "message", text: "ContactLink")
                    })
                    // GitHub Source Link
                    Link(destination:URL(string: "https://github.com/Cizzuk/WebA11Y")!, label: {
                        IconLabel(icon: "ladybug", text: "SourceLink")
                    })
                    // Privacy Policy
                    Link(destination:URL(string: "https://i.cizzuk.net/privacy/")!, label: {
                        IconLabel(icon: "hand.raised", text: "PrivacyPolicyLink")
                    })
                    // License Link
                    NavigationLink(destination: LicenseView()) {
                        IconLabel(icon: "book.closed", text: "License")
                        #if !os(visionOS)
                        .foregroundColor(.accentColor)
                        #endif
                    }
                } header: {
                    Text("SupportLink")
                } footer: {
                    HStack {
                        Text("Version: \(currentVersion ?? "Unknown")")
                        Spacer()
                        Text("© Cizzuk")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("WebA11YSetting")
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
