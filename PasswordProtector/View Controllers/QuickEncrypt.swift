//
//  QuickEncrypt.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/27/21.
//

import Foundation
import UIKit

class QuickEncrypt: UIViewController
{
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var cipherview: UITextView!
    @IBOutlet weak var newtext: UITextView!
    @IBOutlet weak var encryptButton: UIButton!
    @IBOutlet weak var saveEncryption: UIView!
    @IBOutlet weak var shareEncryption: UIView!
    @IBOutlet weak var encryptionCopy: UIView!
    @IBOutlet weak var cipherCopy: UIView!
    
    var cipherString = ""
    var encrypted = ""
    
    var location = ""
    var username = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TabbedPane.stylePane(tabbedView: shareEncryption)
        TabbedPane.stylePane(tabbedView: saveEncryption)
        textfield.addDoneCancelToolbar()
        textfield.styleTextField(textfield)
        encryptButton.layer.cornerRadius = 25
        TabbedPane.stylePane(tabbedView: encryptionCopy)
        TabbedPane.stylePane(tabbedView: cipherCopy)
    }
    
    @IBAction func encryptButtonClicked(_ sender: Any)
    {
        let text = textfield.text!
        let ciphers = CipherCall.fetchCiphers(self)
        
        if ciphers.count == 0
        {
            let alert = UIAlertController(title: "Error 001: Nothing fetched (cipher not found) - Cannot perform encryption!", message: "Can't fetch anything!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        let cipher = ciphers[ciphers.count - 1]
        cipherString = cipher.value(forKey: "cipher") as? String ?? "No cipher!!!"
        
        let encryptedText = SubstitutionEncryption.encrypt(text, cipher.value(forKey: "cipher") as? String ?? "ERROR 001: No Cipher")
        encrypted = encryptedText
        
        newtext.text = "Encrypted Text:\n\(encryptedText)"
        cipherview.text = "Cipher:\n\(cipher.value(forKey: "cipher") as? String ?? "Error 001: No cipher found")"
    }
    
    @IBAction func saveButtonClicked(_ sender: Any)
    {
        location = "Quick"
        
        let alert = UIAlertController(title: "Add Encryption", message: "Enter the information you want. Leave blank what isn't applicable.", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "What this encryption is for..."
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            self.username = alert.textFields![0].text!
            self.password = self.encrypted
            
            CoreDataSaving.save(self.password, self.username, self.location, self.cipherString, self)
        }))
        alert.addAction(UIAlertAction(title: "Don't Add", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonClicked(_ sender: Any)
    {
        let encryptionText = encrypted
        let cipherText = cipherString
        let firstActivityItem = "Encrypted text: \(encryptionText)\nCipher: \(cipherText)\nUse Substitution Decryption!"
        
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
    
    @IBAction func copyEncryption(_ sender: Any)
    {
        Copy.copyText(encrypted)
    }
    
    @IBAction func copyCipher(_ sender: Any)
    {
        Copy.copyText(cipherString)
    }
}
