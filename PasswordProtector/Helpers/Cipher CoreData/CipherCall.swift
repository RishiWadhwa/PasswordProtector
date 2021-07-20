//
//  CipherCall.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/27/21.
//

import Foundation
import CoreData
import UIKit

class CipherCall
{
    static var ciphers: [NSManagedObject] = []
    private static var letterArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    static func fetchCiphers(_ viewcontroller: UIViewController) -> [NSManagedObject]
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return ciphers}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DefaultCipher")
        
        do
        {
            ciphers = try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError
        {
            let alert = UIAlertController(title: "Error 002", message: "Could not fetch data.\n\(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            viewcontroller.present(alert, animated: true, completion: nil)
            
            return ciphers
        }
        
        return ciphers
    }
}
