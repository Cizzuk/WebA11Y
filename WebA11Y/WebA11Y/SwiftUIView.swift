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
    @State private var boldText = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!.bool(forKey: "boldText")
    
    @State private var buttonShape = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!.bool(forKey: "buttonShape")
    
    @State private var fontChange = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!.bool(forKey: "fontChange")
    
    @State private var fontFamily = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!.string(forKey: "fontFamily") ?? "sans-serif"
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Toggle(isOn: $boldText, label: {
                        Text("boldText")
                            .bold()
                    })
                    .onChange(of: boldText) { newValue in
                        if boldText == true {
                            userDefaults!.set("true", forKey: "boldText")
                        }else{
                            userDefaults!.set("false", forKey: "boldText")
                        }
                    }
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
                    .onChange(of: buttonShape) { newValue in
                        if buttonShape == true {
                            userDefaults!.set("true", forKey: "buttonShape")
                        }else{
                            userDefaults!.set("false", forKey: "buttonShape")
                        }
                    }
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
                    .onChange(of: fontChange) { newValue in
                        if fontChange == true {
                            userDefaults!.set("true", forKey: "fontChange")
                        }else{
                            userDefaults!.set("false", forKey: "fontChange")
                        }
                    }
                    TextField("sans-serif", text: $fontFamily)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.done)
                        .accessibilityTextContentType(.sourceCode)
                        .onChange(of: fontFamily) { entered in
                            userDefaults!.set(fontFamily, forKey: "fontFamily")
                        }
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
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    })
                    // Privacy Policy
                    Link(destination:URL(string: "https://tsg0o0.com/privacy/")!, label: {
                        HStack {
                            Image(systemName: "hand.raised")
                                .frame(width: 20.0)
                            Text("PrivacyPolicyLink")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    })
                    // License Link
                    Link(destination:URL(string: "https://www.mozilla.org/en-US/MPL/2.0/")!, label: {
                        HStack {
                            Image(systemName: "book.closed")
                                .frame(width: 20.0)
                            Text("LicenseLink")
                            Spacer()
                            Text("MPL 2.0")
                            Image(systemName: "chevron.right")
                        }
                    })
                    // GitHub Source Link
                    Link(destination:URL(string: "https://github.com/Cizzuk/WebA11Y")!, label: {
                        HStack {
                            Image(systemName: "ladybug")
                                .frame(width: 20.0)
                            Text("SourceLink")
                            Spacer()
                            Text("GitHub")
                            Image(systemName: "chevron.right")
                        }
                    })
                } header: {
                    Text("SupportLink")
                } footer: {
                    HStack {
                        Text("© Cizzuk")
                        Spacer()
                        Text("Version: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("WebA11YSetting")
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
