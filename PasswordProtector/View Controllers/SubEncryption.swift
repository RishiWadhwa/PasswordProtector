//
//  SubEncryption.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/25/21.
//

import Foundation
import UIKit

class SubEncryption: UIViewController
{
    @IBOutlet weak var tabbedPane: UIView!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var cipherView: UITextView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var encryptButton: UIButton!
    @IBOutlet weak var saveText: UIView!
    @IBOutlet weak var shareText: UIView!
    @IBOutlet weak var copyEnc: UIView!
    @IBOutlet weak var copyCip: UIView!
    
    var password = ""
    var username = ""
    var location = ""
    var cipher = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        encryptButton.layer.cornerRadius = 25
        TabbedPane.stylePane(tabbedView: tabbedPane)
        textfield.addDoneCancelToolbar()
        textfield.styleTextField(textfield)
        TabbedPane.stylePane(tabbedView: saveText)
        TabbedPane.stylePane(tabbedView: shareText)
        TabbedPane.stylePane(tabbedView: copyEnc)
        TabbedPane.stylePane(tabbedView: copyCip)
    }
    
    @IBAction func encryptText(_ sender: Any)
    {
        let array = SubstitutionEncryption.encrypt(textfield.text ?? "")
        
        password = array[0]
        cipher = array[1]
        
        textView.text = "New Text:\n\(array[0])"
        cipherView.text = "Cipher:\n\(array[1])"
        
        textView.textColor = .black
        cipherView.textColor = .black
    }
    
    @IBAction func savePassword(_ sender: Any)
    {
        location = "Substitution"
        
        let alert = UIAlertController(title: "Add Encryption", message: "Enter the information you want. Leave blank what isn't applicable.", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "What this encryption is for..."
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            self.username = alert.textFields![0].text!
            
            CoreDataSaving.save(self.password, self.username, self.location, self.cipher, self)
        }))
        alert.addAction(UIAlertAction(title: "Don't Add", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func shareEncryption(_ sender: Any)
    {
        let encryptionText = password
        let cipherText = cipher
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
        cipherView.textColor = Copy.copyText(password)
    }
    
    @IBAction func copyCipher(_ sender: Any)
    {
        textView.textColor = Copy.copyText(cipher)
    }
}

// MARK: UITextField properties
extension UITextField
{
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil)
    {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }
    
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
    
    func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = #colorLiteral(red: 0, green: 0.2, blue: 0.4039215686, alpha: 1)
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        textfield.backgroundColor = .clear
        
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
}
