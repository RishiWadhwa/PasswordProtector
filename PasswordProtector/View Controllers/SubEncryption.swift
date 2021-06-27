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
    }
    
    @IBAction func encryptText(_ sender: Any)
    {
        let array = SubstitutionEncryption.encrypt(textfield.text ?? "")
        
        password = array[0]
        cipher = array[1]
        
        textView.text = "New Text:\n\(array[0])"
        cipherView.text = "Cipher:\n\(array[1])"
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
            
            CoreDataSaving.save(self.password, self.username, self.location, self.cipher, self)
        }))
        
        alert.addAction(UIAlertAction(title: "Don't Save", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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
