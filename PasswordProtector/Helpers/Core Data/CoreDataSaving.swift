//
//  CoreDataSaving.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/25/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataSaving
{
    static var passwords: [NSManagedObject] = []
    
    static func save(_ passwordString: String, _ username: String, _ location: String, _ viewcontroller: UIViewController)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Password", in: managedContext)!
        
        let password = NSManagedObject(entity: entity, insertInto: managedContext)
        password.setValue(passwordString, forKey: "password")
        password.setValue(username, forKey: "username")
        password.setValue(location, forKey: "location")
        
        do
        {
            try managedContext.save()
            passwords.append(password)
        }
        catch let error as NSError
        {
            let alert = UIAlertController(title: "Error 001", message: "Could not save password.\n\(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .cancel, handler: nil))
            
            viewcontroller.present(alert, animated: true, completion: nil)
        }
    }
    
    static func save(_ passwordString: String, _ username: String, _ location: String, _ cipher: String, _ viewcontroller: UIViewController)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Password", in: managedContext)!
        
        let password = NSManagedObject(entity: entity, insertInto: managedContext)
        password.setValue(passwordString, forKey: "password")
        password.setValue(username, forKey: "username")
        password.setValue(location, forKey: "location")
        password.setValue(cipher, forKey: "cipher")
        
        do
        {
            try managedContext.save()
            passwords.append(password)
        }
        catch let error as NSError
        {
            let alert = UIAlertController(title: "Error 001", message: "Could not save password.\n\(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .cancel, handler: nil))
            
            viewcontroller.present(alert, animated: true, completion: nil)
        }
    }

}
