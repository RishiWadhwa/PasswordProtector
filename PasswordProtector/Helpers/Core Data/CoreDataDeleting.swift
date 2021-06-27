//
//  CoreDataDeleting.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/25/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataDeleting
{
    static var passwords: [NSManagedObject] = []
    
    static func deleteItem(_ index: Int, _ viewcontroller: UIViewController)
    {
        passwords = CoreDataFetching.fetchCoreData(viewcontroller: viewcontroller)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(passwords[index])
        do
        {
            try managedContext.save()
        }
        catch let error as NSError
        {
            let alert = UIAlertController(title: "Error 004", message: "Cannot delete object.\n\(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Understood!", style: .cancel, handler: nil))
            
            viewcontroller.present(alert, animated: true, completion: nil)
        }
        
        passwords = CoreDataFetching.fetchCoreData(viewcontroller: viewcontroller)
    }
}
