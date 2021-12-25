//
//  Settings.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/27/21.
//

import Foundation
import UIKit

class Settings: UIViewController
{
    @IBOutlet weak var newCipher: UITextField!
    @IBOutlet weak var setCipher: UIButton!
    @IBOutlet weak var cipherLabel: UILabel!
    @IBOutlet weak var tos: UIButton!
    @IBOutlet weak var infoLink: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCipher.layer.cornerRadius = 25
        newCipher.addDoneCancelToolbar()
        newCipher.styleTextField(newCipher)
        
        let ciphers = CipherCall.fetchCiphers(self)
        if ciphers.count != 0
        {
            cipherLabel.text = "Cipher:\n\(ciphers[ciphers.count-1].value(forKey: "cipher")!)"
        }
        else
        {
            cipherLabel.text = "Cipher:\nNone"
        }
        
        tos.layer.cornerRadius = 25
        
        infoLink.text = "More Information:\nCOMING SOON"
    }
    
    @IBAction func setCipherClicked(_ sender: Any)
    {
        let cipher = newCipher.text!
        
        newCipher.text = ""
        
        if cipher.count > 26 || cipher.count < 26
        {
            let alert = UIAlertController(title: "Error 009: The length of the cipher is too short or too long.", message: "Fix cipher length to 26 characters and try again!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        CipherSend.addCipher(cipher.uppercased(), self)
        cipherLabel.text = "Cipher:\n\(cipher.uppercased())"
    }
    
    @IBAction func infoButtonClicked(_ sender: UIButton)
    {
        let alert = UIAlertController(title: "Info Cipher", message: "The cipher must be 26 characters long. This cipher will be for the Quick Encrypt & Decrypt options where you can use your own cipher to quickly encrypt and decrypt messages without generating a new cipher every time!", preferredStyle: .alert)        
        
        alert.addAction(UIAlertAction(title: "Thanks!", style: .cancel, handler: nil))
    }
}
