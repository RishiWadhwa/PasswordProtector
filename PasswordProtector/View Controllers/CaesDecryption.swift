//
//  CaesDecryption.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/26/21.
//

import Foundation
import UIKit

class CaesDecryption: UIViewController
{
    @IBOutlet weak var tabbedpane: UIView!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var decryptButton: UIButton!
    @IBOutlet weak var newTextLabel: UITextView!
    
    var decrypted = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        TabbedPane.stylePane(tabbedView: tabbedpane)
        textfield.addDoneCancelToolbar()
        textfield.styleTextField(textfield)
        decryptButton.layer.cornerRadius = 25
    }
    
    @IBAction func decryptText(_ sender: Any)
    {
        decrypted = CaesarDecryption.decryptCaesar(textfield.text!)
        newTextLabel.text = "New Text:\n\(decrypted)"
    }
}
