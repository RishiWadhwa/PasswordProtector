//
//  CaesEncryption.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/26/21.
//

import Foundation
import UIKit

class CaesEncryption: UIViewController
{
    @IBOutlet weak var tabbar: UIView!
    @IBOutlet weak var encryptButton: UIButton!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var textLabel: UITextView!
    @IBOutlet weak var saveText: UIView!
    @IBOutlet weak var shareText: UIView!
    
    var password = ""
    var username = ""
    var location = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TabbedPane.stylePane(tabbedView: tabbar)
        encryptButton.layer.cornerRadius = 25
        textfield.addDoneCancelToolbar()
        textfield.styleTextField(textfield)
        TabbedPane.stylePane(tabbedView: saveText)
        TabbedPane.stylePane(tabbedView: shareText)
    }
    
    @IBAction func encryptText()
    {
        password = CaesarEncryption.generateEncryption(textfield.text!)
        textLabel.text = "New Text:\n\(password)"
    }
    
    @IBAction func savePassword(_ sender: Any)
    {
        let alert = UIAlertController(title: "Save Password", message: "Type the username and the place that this password is for. (Leave the non-applicable ones blank)", preferredStyle: .alert)
        
        alert.addTextField { textfield in
            textfield.placeholder = "Username associated with password"
        }
        
        alert.addTextField { textfield in
            textfield.placeholder = "What is this password for"
        }
        
        alert.addAction(UIAlertAction(title: "Save Password", style: .default, handler: { submitButton in
            self.username = alert.textFields![0].text!
            self.location = alert.textFields![1].text!
            
            CoreDataSaving.save(self.password, self.username, self.location, self)
        }))
        
        alert.addAction(UIAlertAction(title: "Don't Save", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func shareEncryption(_ sender: Any)
    {
        let encryptionText = password
        let firstActivityItem = "Encrypted text: \(encryptionText)\nUse Caesar Decryption!"
        
        let image: UIImage = UIImage(named: "PasswordShield")!
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem, image], applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = sender as! UIButton
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.postToTwitter,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        
        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
        
    }
}
