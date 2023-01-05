//
//  SafariWebExtensionHandler.swift
//  WebA11Y Extension
//
//  Created by tsukasa takura on 2023/01/05.
//

import SafariServices
import os.log

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {
    
    let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.weba11y")
    
    func beginRequest(with context: NSExtensionContext) {
        
        let body: Dictionary<String, String> =
        [
            "type": "native",
            "boldText": userDefaults!.string(forKey: "boldText") ?? "false",
            "buttonShape": userDefaults!.string(forKey: "buttonShape") ?? "false",
            "fontChange": userDefaults!.string(forKey: "fontChange") ?? "false",
            "fontFamily": userDefaults!.string(forKey: "fontFamily") ?? "sans-serif",
            "blockARIAHidden": userDefaults!.string(forKey: "blockARIAHidden") ?? "false"
        ]
        do {
            let data = try JSONEncoder().encode(body)
            let json = String(data: data, encoding: .utf8) ?? ""
            let extensionItem = NSExtensionItem()
            extensionItem.userInfo = [ SFExtensionMessageKey: json ]
            context.completeRequest(returningItems: [extensionItem], completionHandler: nil)
        } catch {
            print("error")
        }
    }

}
