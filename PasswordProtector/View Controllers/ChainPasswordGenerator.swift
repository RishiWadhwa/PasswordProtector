//
//  ChainPasswordGenerator.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 11/8/21.
//

import Foundation
import UIKit

class ChainPasswordGenerator: UIViewController
{
    @IBOutlet weak var chainNumLabel: UILabel!
    @IBOutlet weak var charNumLabel: UILabel!
    @IBOutlet weak var chainNumStep: UIStepper!
    @IBOutlet weak var charNumStep: UIStepper!
    @IBOutlet weak var generatePassword: UIButton!
    @IBOutlet weak var copyPassword: UIButton!
    @IBOutlet weak var passwordLabel: UITextView!
    @IBOutlet weak var includeNumbersVisual: UIImageView!
    @IBOutlet weak var copyView: UIView!
    
    var enableNumbers = false
    var chainLen = 4
    var chars = 5
    var password = ""
    
    override func viewDidLoad()
    {
        generatePassword.layer.cornerRadius = 25
        copyPassword.layer.cornerRadius = 25
        TabbedPane.stylePane(tabbedView: copyView)
    }
    
    @IBAction func enableOrDisableImage(_ sender: Any)
    {
        if includeNumbersVisual.isHighlighted
        {
            includeNumbersVisual.isHighlighted = false
            enableNumbers = false
        }
        else
        {
            includeNumbersVisual.isHighlighted = true
            enableNumbers = true
        }
    }
    
    @IBAction func chainLengthChanged(_ sender: UIStepper)
    {
        chainLen = Int(sender.value)
        chainNumLabel.text = "Number of Chains: \(chainLen)"
    }
    
    @IBAction func chainCharsChanged(_ sender: UIStepper)
    {
        chars = Int(sender.value)
        charNumLabel.text = "Char per Chain: \(chars)"
    }
    
    @IBAction func generatePasswordChain(_ sender: UIButton)
    {
        password = ChainGeneration.generatePasswordChain(chainLen, chars, enableNumbers)
        passwordLabel.text = password
        passwordLabel.textColor = .black
    }
    
    @IBAction func copyChainPassword(_ sender: UIButton)
    {
        passwordLabel.textColor = Copy.copyText(password)
    }
}
