//
//  PasswordLoader.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/25/21.
//

import Foundation
import UIKit
import CoreData

class PasswordLoader: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tabbedPane: UIView!
    @IBOutlet weak var addNewPassword: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var cipher = ""
    var password = ""
    var username = ""
    var location = ""
    
    var passwords: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TabbedPane.stylePane(tabbedView: tabbedPane)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadPasswords()
        tableView.reloadData()
        
        let nib = UINib(nibName: "PasswordTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func addPasswordButtonPressed(_ sender: Any)
    {
        location = ""
        username = ""
        password = ""
        
        let alert = UIAlertController(title: "Add Encryption", message: "Enter the information you want. Leave blank what isn't applicable.", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "What this encryption is for..."
        }
        alert.addTextField { field in
            field.placeholder = "Encryption... "
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { action in
            self.username = alert.textFields![0].text!
            self.password = alert.textFields![1].text!
            
            CoreDataSaving.save(self.password, self.username, self.location, self)
        }))
        alert.addAction(UIAlertAction(title: "Don't Add", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadPasswords()
    {
        passwords = CoreDataFetching.fetchCoreData(viewcontroller: self)
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return passwords.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PasswordTableViewCell
        
        cipher = passwords[indexPath.row].value(forKey: "cipher") as? String ?? "N/A"
        
        cell.locationLabel.text = "\(passwords[indexPath.row].value(forKey: "location") as? String ?? "") Encryption"
        
        cell.passwordLabel.text = "Password: \(passwords[indexPath.row].value(forKey: "password") as? String ?? "")"
        
        cell.layer.borderColor = CGColor(red: 0, green: 51, blue: 103, alpha: 0.3)
        cell.layer.borderWidth = 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        cipher = passwords[indexPath.row].value(forKey: "cipher") as? String ?? "N/A"
        if cipher == ""
        {
            cipher = "N/A"
        }
        
        location = passwords[indexPath.row].value(forKey: "location") as? String ?? ""
        password = passwords[indexPath.row].value(forKey: "password") as? String ?? "N/A"
        
        
        
        let alert = UIAlertController(title: "\(location) Encryption", message: "What this is for:\n\(passwords[indexPath.row].value(forKey: "username") ?? "N/A")\nEncryption: \(password)\nCipher:\n\(cipher)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Copy Password & Encryption", style: .default, handler: { alert in
            Copy.copyText("\(self.location) Encryption\nPassword: \(self.password)\nEncryption: \(self.cipher)")
        }))
        
        alert.addAction(UIAlertAction(title: "Share Password & Encryption", style: .default, handler: { alert in
            
            let encryptionText = self.password
            let cipherText = self.cipher
            let firstActivityItem = "Encrypted text: \(encryptionText)\nCipher: \(cipherText)\nUse Substitution Decryption!"
            
            let image: UIImage = UIImage(named: "PasswordShield")!
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem, image], applicationActivities: nil)
            
            activityViewController.popoverPresentationController?.sourceView = self.addNewPassword
            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
            activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
            activityViewController.activityItemsConfiguration = [
                UIActivity.ActivityType.message
            ] as? UIActivityItemsConfigurationReading
            
            
            activityViewController.excludedActivityTypes = [
                UIActivity.ActivityType.postToFlickr,
                UIActivity.ActivityType.postToVimeo,
                UIActivity.ActivityType.postToWeibo,
                UIActivity.ActivityType.postToTwitter,
                UIActivity.ActivityType.postToTencentWeibo,
                UIActivity.ActivityType.postToFacebook
            ]
            
            activityViewController.isModalInPresentation = true
            self.present(activityViewController, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Got it!", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        CoreDataDeleting.deleteItem(indexPath.row, self)
        loadPasswords()
        tableView.reloadData()
    }
}
