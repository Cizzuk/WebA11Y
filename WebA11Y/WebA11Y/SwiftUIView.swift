//
//  SwiftUIView.swift
//  WebA11Y
//
//  Created by Cizzuk on 2024/03/23.
//

import SwiftUI

@main
struct MainView: App {
#if iOS
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#endif
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
