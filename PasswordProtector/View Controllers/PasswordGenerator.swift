//
//  PasswordGenerator.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/24/21.
//

import Foundation
import UIKit
import CoreData

class PasswordGenerator: UIViewController
{
    @IBOutlet weak var tabBar: UIView!
    @IBOutlet weak var passwordLen: UIStepper!
    @IBOutlet weak var generatePassword: UIButton!
    @IBOutlet weak var circleImage: UIImageView!
    @IBOutlet weak var passwordLengthLabel: UILabel!
    @IBOutlet weak var passwordLabel: UITextView!
    @IBOutlet weak var savePasswordView: UIView!
    
    var enableSpecialCharacters = false
    var passwordLength = 8
    
    var userInputUsername = ""
    var userInputLocation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TabbedPane.stylePane(tabbedView: tabBar)
        generatePassword.layer.cornerRadius = 25
        
        TabbedPane.stylePane(tabbedView: savePasswordView)
    }
    
    @IBAction func savePasswordButtonClicked(_ sender: Any)
    {
        let alert = UIAlertController(title: "Save Password", message: "Type the username and the place that this password is for. (Leave the non-applicable ones blank)", preferredStyle: .alert)
        
        alert.addTextField { textfield in
            textfield.placeholder = "Username associated with password"
        }
        
        alert.addTextField { textfield in
            textfield.placeholder = "What is this password for"
        }
        
        alert.addAction(UIAlertAction(title: "Save Password", style: .default, handler: { submitButton in
            self.userInputUsername = alert.textFields![0].text!
            self.userInputLocation = alert.textFields![1].text!
            
            CoreDataSaving.save(self.passwordLabel.text!, self.userInputUsername, self.userInputLocation, self)
        }))
        
        alert.addAction(UIAlertAction(title: "Don't Save", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func enableOrDisableImage(_ sender: Any)
    {
        if circleImage.isHighlighted
        {
            circleImage.isHighlighted = false
            enableSpecialCharacters = false
        }
        else
        {
            circleImage.isHighlighted = true
            enableSpecialCharacters = true
        }
    }
    
    @IBAction func passwordLengthChanged(_ sender: UIStepper)
    {
        passwordLength = Int(sender.value)
        passwordLengthLabel.text = "Password Length: \(passwordLength)"
    }
    
    @IBAction func generatePasswordClicked(_ sender: Any)
    {
        if enableSpecialCharacters
        {
            passwordLabel.text = GeneratePassword.MakeSpecialPassword(passwordLength)
        }
        else
        {
            passwordLabel.text = GeneratePassword.MakePassword(passwordLength)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func highlightImage(_ sender: Any)
    {
        enableOrDisableImage(sender)
    }
}
