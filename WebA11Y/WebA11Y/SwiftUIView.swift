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
    
    let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")
    @AppStorage("boldText", store: UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")) var boldText: Bool = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!.bool(forKey: "boldText")
    
    @AppStorage("buttonShape", store: UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")) var buttonShape: Bool = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!.bool(forKey: "buttonShape")
    
    @AppStorage("fontChange", store: UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")) var fontChange: Bool = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!.bool(forKey: "fontChange")
    
    @AppStorage("fontFamily", store: UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")) var fontFamily: String = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!.string(forKey: "fontFamily") ?? "sans-serif"
    
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
                    Toggle(isOn: $boldText, label: {
                        Text("boldText")
                            .bold()
                    })
                } footer: {
                    VStack (alignment : .leading) {
                        Text("boldText-Desc-1")
                        Text("boldText-Desc-2")
                    }
                }
                Section {
                    Toggle(isOn: $buttonShape, label: {
                        Text("buttonShape")
                            .underline()
                    })
                } footer: {
                    VStack (alignment : .leading) {
                        Text("buttonShape-Desc-1")
                        Text("buttonShape-Desc-2")
                    }
                }
                Section {
                    Toggle(isOn: $fontChange, label: {
                        Text("fontChange")
                            .font(.system(.body, design: .serif))
                    })
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
                        HStack {
                            Image(systemName: "message")
                                .frame(width: 20.0)
                            Text("ContactLink")
                        }
                    })
                    // Privacy Policy
                    Link(destination:URL(string: "https://tsg0o0.com/privacy/")!, label: {
                        HStack {
                            Image(systemName: "hand.raised")
                                .frame(width: 20.0)
                            Text("PrivacyPolicyLink")
                        }
                    })
                    // License Link
                    NavigationLink {
                        LicenseView()
                    } label: {
                        HStack {
                            Image(systemName: "book.closed")
                                .frame(width: 20.0)
                            Text("License")
                        }
                        .foregroundColor(.accentColor)
                    }
                    // GitHub Source Link
                    Link(destination:URL(string: "https://github.com/Cizzuk/WebA11Y")!, label: {
                        HStack {
                            Image(systemName: "ladybug")
                                .frame(width: 20.0)
                            Text("SourceLink")
                        }
                    })
                } header: {
                    Text("SupportLink")
                } footer: {
                    HStack {
                        Text("Version: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)")
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
