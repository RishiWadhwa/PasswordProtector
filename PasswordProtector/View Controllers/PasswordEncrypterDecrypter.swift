//
//  PasswordEncrypterDecrypter.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/25/21.
//

import Foundation
import UIKit

class PasswordEncrypterDecrypter: UIViewController
{
    @IBOutlet weak var tabbedPane: UIView!
    @IBOutlet weak var encryptButton: UIButton!
    @IBOutlet weak var decryptButton: UIButton!
    @IBOutlet weak var quickencryptButton: UIButton!
    @IBOutlet weak var quickdecryptButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        TabbedPane.stylePane(tabbedView: tabbedPane)
        
        encryptButton.layer.cornerRadius = 25
        decryptButton.layer.cornerRadius = 25
        quickencryptButton.layer.cornerRadius = 25
        quickdecryptButton.layer.cornerRadius = 25
    }
    
    
}
