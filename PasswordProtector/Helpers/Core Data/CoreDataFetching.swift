//
//  CoreDataFetching.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/25/21.
//

import Foundation
import UIKit
import CoreData

class CoreDataFetching
{
    static var passwords: [NSManagedObject] = []
    
    static func fetchCoreData(viewcontroller: UIViewController) -> [NSManagedObject]
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return passwords}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Password")
        
        do
        {
            passwords = try managedContext.fetch(fetchRequest)
        }
        catch let error as NSError
        {
            let alert = UIAlertController(title: "Error 002", message: "Could not fetch data.\n\(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            viewcontroller.present(alert, animated: true, completion: nil)
            
            return passwords
        }
        
        return passwords
    }
}
