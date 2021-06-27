//
//  SubstitutionDecryption.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/26/21.
//

import Foundation
import UIKit

class SubstitutionDecryption: UIViewController
{
    private static var letterArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    static func decryptText(_ text: String, _ cipher: String) -> String
    {
        var newText = ""
        var textAgain = text
        var cipherText = cipher
        var cipherArray: [String] = []
        
        for _ in 0..<cipher.count
        {
            let index = cipherText.index(cipherText.startIndex, offsetBy: 1)
            let substring = String(cipherText.prefix(upTo: index))
            cipherArray.append(substring)
            
            cipherText = String(cipherText.suffix(from: index))
        }
        
        var location = letterArray.firstIndex(of: "A")
        
        for _ in 0..<textAgain.count
        {
            let index = textAgain.index(textAgain.startIndex, offsetBy: 1)
            let substring = String(textAgain.prefix(upTo: index))
            location = cipherArray.firstIndex(of: substring.uppercased())
            
            textAgain = String(textAgain.suffix(from: index))
            
            if location == nil && substring != " "
            {
                return "ERROR 003: INVALID CHARACTER | TEXT SHOULD ONLY BE CHARACTERS"
            }
            else if substring == " "
            {
                newText += " "
            }
            else
            {
                if substring.uppercased() == substring
                {
                    newText += letterArray[location!]
                }
                else
                {
                    newText += letterArray[location!].lowercased()
                }
            }
        }
        
        return newText
    }
}
