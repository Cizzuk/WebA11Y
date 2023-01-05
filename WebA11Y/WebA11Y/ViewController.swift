//
//  ViewController.swift
//  WebA11Y
//
//  Created by tsg0o0 on 2023/01/05.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLabel.text = "WebA11Y / Ver:  \(version)"
        versionLabel.accessibilityLabel = "WebA11Y. Version \(version)"
    }
    
}
