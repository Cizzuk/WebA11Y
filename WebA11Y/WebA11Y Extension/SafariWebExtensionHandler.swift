//
//  SafariWebExtensionHandler.swift
//  WebA11Y Extension
//
//  Created by Cizzuk on 2023/01/05.
//

import SafariServices

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {
    
    let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.safariweba11y")!
    
    func beginRequest(with context: NSExtensionContext) {
        // Load settings
        let boldText: Bool = userDefaults.bool(forKey: "boldText")
        let buttonShape: Bool = userDefaults.bool(forKey: "buttonShape")
        let fontChange: Bool = userDefaults.bool(forKey: "fontChange")
        
        // Handle no settings
        if !boldText && !buttonShape && !fontChange {
            sendData(context: context, data: ["type" : "none"])
            return
        }
        
        // Set fontFamily
        let fontFamily: String = userDefaults.string(forKey: "fontFamily") ?? "sans-serif"
        let fontFamilyFixed: String = fontFamily == "" ? "sans-serif" : fontFamily
        
        // Create style sheet
        var styleSheet: String = ""
        if boldText    { styleSheet += "* { font-weight: bold !important; }" }
        if buttonShape { styleSheet += "a, button { text-decoration: underline !important; }" }
        if fontChange  { styleSheet += "* { font-family: \(fontFamilyFixed) !important; }" }
        
        struct dataSet: Encodable {
            let type: String
            let style: String
        }
        
        let Data = dataSet(
            type: "run",
            style: styleSheet
        )
        
        // Send to background.js!
        sendData(context: context, data: Data)
    }
    
    func sendData(context: NSExtensionContext, data: Encodable) {
        do {
            let data = try JSONEncoder().encode(data)
            let json = String(data: data, encoding: .utf8)!
            let extensionItem = NSExtensionItem()
            extensionItem.userInfo = [ SFExtensionMessageKey: json ]
            context.completeRequest(returningItems: [extensionItem], completionHandler: nil)
        } catch {
            print("error")
        }
    }

}
