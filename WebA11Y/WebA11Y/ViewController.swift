//
//  ViewController.swift
//  WebA11Y
//
//  Created by tsg0o0 on 2023/01/05.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var boldTextSwitch: UISwitch!
    @IBOutlet weak var buttonShapesSwitch: UISwitch!
    @IBOutlet weak var fontChangeSwitch: UISwitch!
    @IBOutlet weak var blockARIAHiddenSwitch: UISwitch!
    @IBOutlet weak var fontChangeInput: UITextField!
    
    
    @IBOutlet weak var buttonShapeTitle: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    let userDefaults = UserDefaults(suiteName: "group.com.tsg0o0.weba11y")
    var boldText:String = "false"
    var buttonShape:String = "false"
    var fontChange:String = "false"
    var fontFamily:String = "sans-serif"
    var blockARIAHidden:String = "false"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLabel.text = "WebA11Y / Ver: \(version)"
        versionLabel.accessibilityLabel = "WebA11Y. Version \(version)"
        if Locale.current.languageCode == "ja" {
            buttonShapeTitle.text = "ボタンの形"
        }
        
        
        //Automatic configuration at first startup
        if userDefaults!.string(forKey: "boldText") == nil {
            if UIAccessibility.isBoldTextEnabled {
                userDefaults!.set("true", forKey: "boldText")
            }else{
                userDefaults!.set("false", forKey: "boldText")
            }
        }
        if userDefaults!.string(forKey: "buttonShape") == nil {
            if UIAccessibility.buttonShapesEnabled {
                userDefaults!.set("true", forKey: "buttonShape")
            }else{
                userDefaults!.set("false", forKey: "buttonShape")
            }
        }
        
        boldText = userDefaults!.string(forKey: "boldText") ?? "false"
        buttonShape = userDefaults!.string(forKey: "buttonShape") ?? "false"
        fontChange = userDefaults!.string(forKey: "fontChange") ?? "false"
        fontFamily = userDefaults!.string(forKey: "fontFamily") ?? "sans-serif"
        blockARIAHidden = userDefaults!.string(forKey: "blockARIAHidden") ?? "false"
        
        fontChangeInput.text! = userDefaults!.string(forKey: "fontFamily") ?? "sans-serif"
        
        if boldText == "true" {
            boldTextSwitch.isOn = true
            boldTextSwitch.sendActions(for: .valueChanged)
        }else{
            boldTextSwitch.isOn = false
            boldTextSwitch.sendActions(for: .valueChanged)
        }
        if buttonShape == "true" {
            buttonShapesSwitch.isOn = true
            buttonShapesSwitch.sendActions(for: .valueChanged)
        }else{
            buttonShapesSwitch.isOn = false
            buttonShapesSwitch.sendActions(for: .valueChanged)
        }
        if fontChange == "true" {
            fontChangeSwitch.isOn = true
            fontChangeSwitch.sendActions(for: .valueChanged)
        }else{
            fontChangeSwitch.isOn = false
            fontChangeSwitch.sendActions(for: .valueChanged)
        }
        if blockARIAHidden == "true" {
            blockARIAHiddenSwitch.isOn = true
            blockARIAHiddenSwitch.sendActions(for: .valueChanged)
        }else{
            blockARIAHiddenSwitch.isOn = false
            blockARIAHiddenSwitch.sendActions(for: .valueChanged)
        }
    }
    
    //Bold Text
    
    @IBAction func boldTextChange(_ sender: Any) {
        if (sender as AnyObject).isOn {
            boldText = "true"
            userDefaults!.set(boldText, forKey: "boldText")
        }else{
            boldText = "false"
            userDefaults!.set(boldText, forKey: "boldText")
        }
    }
    
    //Button Shapes
    
    @IBAction func buttonShapesChange(_ sender: Any) {
        if (sender as AnyObject).isOn {
            buttonShape = "true"
            userDefaults!.set(buttonShape, forKey: "buttonShape")
        }else{
            buttonShape = "false"
            userDefaults!.set(buttonShape, forKey: "buttonShape")
        }
    }
    
    //Font Change
    
    @IBAction func fontChangeChange(_ sender: Any) {
        if (sender as AnyObject).isOn {
            fontChange = "true"
            userDefaults!.set(fontChange, forKey: "fontChange")
        }else{
            fontChange = "false"
            userDefaults!.set(fontChange, forKey: "fontChange")
        }
    }
    @IBAction func editFontChangeInput(_ sender: Any) {
        fontFamily = fontChangeInput.text!
        userDefaults!.set(fontFamily, forKey: "fontFamily")
    }
    
    //Block aria-hidden
    
    @IBAction func blockARIAHiddenChange(_ sender: Any) {
        if (sender as AnyObject).isOn {
            blockARIAHidden = "true"
            userDefaults!.set(blockARIAHidden, forKey: "blockARIAHidden")
        }else{
            blockARIAHidden = "false"
            userDefaults!.set(blockARIAHidden, forKey: "blockARIAHidden")
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func endFontChangeInput(_ sender: Any) {
    }
    
}
