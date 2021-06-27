//
//  SubsDecryption.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/26/21.
//

import Foundation
import UIKit

class SubsDecryption: UIViewController
{
    @IBOutlet weak var decryptButton: UIButton!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var cipherField: UITextField!
    @IBOutlet weak var newTextLabel: UITextView!
    @IBOutlet weak var tabbedpane: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        TabbedPane.stylePane(tabbedView: tabbedpane)
        textfield.addDoneCancelToolbar()
        textfield.styleTextField(textfield)
        cipherField.addDoneCancelToolbar()
        cipherField.styleTextField(cipherField)
        decryptButton.layer.cornerRadius = 25
    }
    
    @IBAction func DecryptText(_ sender: Any)
    {
        if (cipherField.text == nil) || textfield.text == nil
        {
            let alert = UIAlertController(title: "ERROR 005", message: "ONE OR MORE FIELDS BLANK!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Will fill in the field(s)!", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            newTextLabel.text = "Decrypted Text:\n\(SubstitutionDecryption.decryptText(textfield.text!, cipherField.text!))"
        }
    }
}
