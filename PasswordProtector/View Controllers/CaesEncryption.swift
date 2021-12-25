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
    @IBOutlet weak var copyEnc: UIView!
    
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
        TabbedPane.stylePane(tabbedView: copyEnc)
    }
    
    @IBAction func encryptText()
    {
        password = CaesarEncryption.generateEncryption(textfield.text!)
        textLabel.text = "New Text:\n\(password)"
        textLabel.textColor = .black
    }
    
    @IBAction func savePassword(_ sender: Any)
    {
        location = "Caesar"
        
        let alert = UIAlertController(title: "Add Encryption", message: "Enter the information you want. Leave blank what isn't applicable.", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "What this encryption is for..."
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            self.username = alert.textFields![0].text!
            
            CoreDataSaving.save(self.password, self.username, self.location, self)
        }))
        alert.addAction(UIAlertAction(title: "Don't Add", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func shareEncryption(_ sender: Any)
    {
        let encryptionText = password
        let firstActivityItem = "\(encryptionText)"
        
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
    
    @IBAction func copyText(_ sender: Any)
    {
        textfield.textColor = Copy.copyText(password)
    }
}
