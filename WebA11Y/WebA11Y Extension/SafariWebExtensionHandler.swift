//
//  SafariWebExtensionHandler.swift
//  WebA11Y Extension
//
//  Created by tsg0o0 on 2023/01/05.
//

import SafariServices
import os.log

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {
    
    let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")
    var fontFamilyString:String = "sans-serif"
    
    func beginRequest(with context: NSExtensionContext) {
        
        fontFamilyString = userDefaults!.string(forKey: "fontFamily") ?? "sans-serif"
        if fontFamilyString == "" {
            fontFamilyString = "sans-serif"
        }
        
        let body: Dictionary<String, String> =
        [
            "type": "native",
            "boldText": userDefaults!.string(forKey: "boldText") ?? "false",
            "buttonShape": userDefaults!.string(forKey: "buttonShape") ?? "false",
            "fontChange": userDefaults!.string(forKey: "fontChange") ?? "false",
            "fontFamily": fontFamilyString
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
