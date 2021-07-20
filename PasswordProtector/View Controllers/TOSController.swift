//
//  TOSController.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 7/19/21.
//

import Foundation
import UIKit
import WebKit

class TOSController: UIViewController, WKNavigationDelegate, WKUIDelegate
{
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        webview.uiDelegate = self
        
        view.addSubview(webview)
        
        let path = Bundle.main.path(forResource: "OWEL_TOS", ofType: "pdf")
        var url = URL(string: "")
        if path == nil {
            url = URL(string: "https://developer.qoom.space/~/homepage/owel-tos")
        } else {
            url = URL(fileURLWithPath: path!)
        }
        
        webview.load(URLRequest(url: url!))
        let doneButton = UIBarButtonItem(title: "Accept", style: .done, target: self, action: #selector(doneButtonPressed(sender:)))
        navigationItem.rightBarButtonItem = doneButton
        
        if traitCollection.userInterfaceStyle == .light {
            navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0.2, blue: 0.4039215686, alpha: 1)
            navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else if traitCollection.userInterfaceStyle == .dark {
            navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.2740980089, green: 0.7029664516, blue: 0.8989340663, alpha: 1)
            navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        webview.tintColor = #colorLiteral(red: 0, green: 0.2, blue: 0.4039215686, alpha: 1)
    }
    
    @objc func doneButtonPressed(sender: Any) {
        self.performSegue(withIdentifier: "backFromTOS", sender: sender)
    }
}
