//
//  ChangeIconView.swift
//  WebA11Y
//
//  Created by Cizzuk on 2026/02/09.
//

import SwiftUI

struct ChangeIconView: View {
    var body: some View {
        List {
            Section {
                iconItem(iconName: "WebA11Y", iconID: "AppIcon")
                iconItem(iconName: "Pride", iconID: "Pride")
                iconItem(iconName: "Unity", iconID: "Unity")
            }
        }
        .navigationTitle("Change App Icon")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func iconItem(iconName: String, iconID: String) -> some View {
        HStack {
            Image(iconID + "-pre")
                .resizable()
                .frame(width: 64, height: 64)
                .accessibilityHidden(true)
                .padding(8)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            Text(iconName)
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            // Change App Icon
            if iconID == "AppIcon" {
                UIApplication.shared.setAlternateIconName(nil)
            } else {
                UIApplication.shared.setAlternateIconName(iconID)
            }
        }
    }
}
