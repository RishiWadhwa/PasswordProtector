//
//  CipherSend.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/27/21.
//

import Foundation
import CoreData
import UIKit

class CipherSend
{
    static var ciphers: [NSManagedObject] = []
    
    static func addCipher(_ cipher: String, _ viewcontroller: UIViewController)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            let alert = UIAlertController(title: "Error 005: Cannot find App Delegate", message: "Error has occurred. Cannot save!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yep!", style: .cancel, handler: nil))
            
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let overview = NSEntityDescription.entity(forEntityName: "DefaultCipher", in: managedContext)!
        
        let entity = NSManagedObject(entity: overview, insertInto: managedContext)
        entity.setValue(cipher, forKey: "cipher")
        
        do
        {
            try managedContext.save()
            ciphers.append(entity)
        }
        catch let error as NSError
        {
            let alert = UIAlertController(title: "Error 001", message: "Could not save password.\n\(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .cancel, handler: nil))
            
            viewcontroller.present(alert, animated: true, completion: nil)
        }
    }
}
