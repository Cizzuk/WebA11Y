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
    @AppStorage("blockAnimations", store: userDefaults) var blockAnimations: Bool = false
    @AppStorage("fontChange", store: userDefaults) var fontChange: Bool = false
    @AppStorage("insertCSS", store: userDefaults) var insertCSS: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    #if !targetEnvironment(macCatalyst)
                    Button(action: {
                        if let url = URL(string: "App-Prefs:com.apple.mobilesafari") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        IconLabel(icon: "gear", text: "Open Settings")
                            #if !os(visionOS)
                            .foregroundColor(.accentColor)
                            #endif
                    }
                    #endif
                } footer: {
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
                
                // Block Animations
                Section {
                    Toggle(isOn: $blockAnimations) {
                        IconLabel(icon: "circle.dotted.and.circle", text: "Block Animations")
                    }
                    .onChange(of: blockAnimations) { _ in
                        #if !os(visionOS)
                        if #available(iOS 18.0, macOS 26, *) {
                            ControlCenter.shared.reloadControls(ofKind: "com.tsg0o0.weba11y.CCWidget.blockAnimations")
                        }
                        #endif
                    }
                } footer: {
                    VStack (alignment : .leading) {
                        Text("Blocks some animations and transitions.")
                        Text("Some pages may not display correctly. Also recommended to enable \"Reduce Motion\" in device settings.")
                    }
                }
                
                // Custom Font
                Section {
                    NavigationLink(destination: CustomFontView()) {
                        HStack {
                            IconLabel(icon: "textformat", text: "Custom Font")
                            Spacer()
                            Text(fontChange ? "On" : "Off")
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                } footer: {
                    VStack (alignment : .leading) {
                        Text("Change the font.")
                        Text("Icons will not display correctly on some pages.")
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
                        IconLabel(icon: "info.circle", text: "About")
                    }
                    if UIApplication.shared.supportsAlternateIcons {
                        NavigationLink(destination: ChangeIconView()) {
                            IconLabel(icon: "app.dashed", text: "Change App Icon")
                        }
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
    
    let customIconNames: Set<String> = [
        "circle.dotted.and.circle"
    ]
    
    var body: some View {
        HStack {
            if dynamicTypeSize <= .xxxLarge {
                Group {
                    if customIconNames.contains(icon) {
                        Image(icon)
                    } else {
                        Image(systemName: icon)
                    }
                }
                .frame(width: 20.0, alignment: .center)
                .accessibilityHidden(true)
                Spacer().frame(width: 10.0)
            }
            Text(String(localized: text))
        }
    }
}
