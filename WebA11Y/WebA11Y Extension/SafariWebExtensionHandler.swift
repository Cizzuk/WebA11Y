//
//  SafariWebExtensionHandler.swift
//  WebA11Y Extension
//
//  Created by Cizzuk on 2023/01/05.
//

import SafariServices

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {
    
    let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")
    var fontFamilyFixed: String = "sans-serif"
    
    func beginRequest(with context: NSExtensionContext) {
        
        fontFamilyFixed = userDefaults!.string(forKey: "fontFamily") ?? "sans-serif"
        if fontFamilyFixed == "" {
            fontFamilyFixed = "sans-serif"
        }
        
        struct Settings: Encodable {
            let type: String
            let boldText: Bool
            let buttonShape: Bool
            let fontChange: Bool
            let fontFamily: String
        }
        
        let settings = Settings(
            type: "native",
            boldText: userDefaults!.bool(forKey: "boldText"),
            buttonShape: userDefaults!.bool(forKey: "buttonShape"),
            fontChange: userDefaults!.bool(forKey: "fontChange"),
            fontFamily: fontFamilyFixed
        )
        
        do {
            let data = try JSONEncoder().encode(settings)
            let json = String(data: data, encoding: .utf8)!
            let extensionItem = NSExtensionItem()
            extensionItem.userInfo = [ SFExtensionMessageKey: json ]
            context.completeRequest(returningItems: [extensionItem], completionHandler: nil)
        } catch {
            print("error")
        }
    }

}
