//
//  QuickDecryption.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/28/21.
//

import Foundation
import UIKit

class QuickDecryption: UIViewController
{
    @IBOutlet weak var decrypt: UIButton!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var decryptedLabel: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        decrypt.layer.cornerRadius = 25
        textfield.styleTextField(textfield)
        textfield.addDoneCancelToolbar()
    }
    
    @IBAction func decryptClicked(_ sender: Any)
    {
        let text = textfield.text ?? ""
        
        let ciphers = CipherCall.fetchCiphers(self)
        
        if ciphers.count == 0
        {
            let alert = UIAlertController(title: "Error 001: Nothing fetched (cipher not found) - Cannot perform encryption!", message: "Can't fetch anything!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        let cipher = ciphers[ciphers.count - 1]
        let cipherString = cipher.value(forKey: "cipher") as? String ?? "No cipher!!!"
        
        if cipherString == "No cipher!!!"
        {
            decryptedLabel.text = "Decrypted Text:\nNo cipher! Error 001: Can't decrypt without default cipher in settings!"
            return
        }
        
        let decryptedText = SubstitutionDecryption.decryptText(text, cipherString)
        
        decryptedLabel.text = "Decrypted Text:\n\(decryptedText)"
    }
}
