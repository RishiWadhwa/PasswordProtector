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
    
    var password = ""
    
    var userInputUsername = ""
    var userInputLocation = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TabbedPane.stylePane(tabbedView: tabBar)
        generatePassword.layer.cornerRadius = 25
        
        TabbedPane.stylePane(tabbedView: savePasswordView)
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
            password = GeneratePassword.MakeSpecialPassword(passwordLength)
            passwordLabel.text = password
        }
        else
        {
            password = GeneratePassword.MakePassword(passwordLength)
            passwordLabel.text = password
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func highlightImage(_ sender: Any)
    {
        enableOrDisableImage(sender)
    }
    
    @IBAction func copyText(_ sender: Any)
    {
        Copy.copyText(password)
    }
}
