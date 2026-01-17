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
        let blockAnimations: Bool = userDefaults.bool(forKey: "blockAnimations")
        let fontChange: Bool = userDefaults.bool(forKey: "fontChange")
        let insertCSS: Bool = userDefaults.bool(forKey: "insertCSS")
        
        // Handle no settings
        if !boldText && !buttonShape && !blockAnimations && !fontChange && !insertCSS {
            sendData(context: context, data: ["type" : "none"])
            return
        }
        
        // Set fontFamily
        let fontFamily: String = userDefaults.string(forKey: "fontFamily") ?? "system-ui, sans-serif"
        let fontFamilyFixed: String = fontFamily == "" ? "system-ui, sans-serif" : fontFamily
        
        // Set custom CSS
        let customCSS: String = userDefaults.string(forKey: "customCSS") ?? ""
        
        // Create style sheet
        var styleSheet: String = ""
        if boldText {
            styleSheet += """
            * {
              font-weight: bold !important;
            }
            """
        }
        if buttonShape {
            styleSheet += """
            a,
            button,
            input[type=\"button\"],
            input[type=\"submit\"],
            input[type=\"reset\"] {
              text-decoration: underline !important;
            }
            """
        }
        if blockAnimations {
            styleSheet += """
            * {
              animation: none !important;
              transition: note !important;
              view-transition-name: none !important;
            }
            @view-transition {
              navigation: none !important;
            }
            """
        }
        if fontChange {
            styleSheet += """
            * {
              font-family: \(fontFamilyFixed) !important;
            }
            """
        }
        if insertCSS { styleSheet += customCSS }
        
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
