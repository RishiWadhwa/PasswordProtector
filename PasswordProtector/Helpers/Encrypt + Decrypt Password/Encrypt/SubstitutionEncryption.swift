//
//  SubstitutionEncryption.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/25/21.
//

import Foundation
import UIKit

class SubstitutionEncryption
{
    private static var letterArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    private static func generateCipher() -> [String]
    {
        var cipher = letterArray
        cipher.shuffle()
        
        return cipher
    }
    
    static func encrypt(_ text: String) -> [String]
    {
        var textRepeat = text
        var newText = ""
        
        let cipherArray = generateCipher()
        
        var cipher = ""
        for i in 0..<cipherArray.count
        {
            cipher += cipherArray[i]
        }
        
        var location = letterArray.firstIndex(of: "A")
        
        for _ in 0..<text.count
        {
            let index = textRepeat.index(textRepeat.startIndex, offsetBy: 1)
            let substring = String(textRepeat.prefix(upTo: index))
            location = letterArray.firstIndex(of: substring.uppercased())
            
            textRepeat = String(textRepeat.suffix(from: index))
            
            if location == nil && substring != " "
            {
                let array = ["ERROR 003: INVALID CHARACTER | TEXT SHOULD ONLY BE CHARACTERS", "INVALID TEXT NO CIPHER GENERATED"]
                
                return array
            }
            else if substring == " "
            {
                newText += " "
            }
            else
            {
                if substring.uppercased() == substring
                {
                    newText += cipherArray[location!]
                }
                else
                {
                    newText += cipherArray[location!].lowercased()
                }
            }                        
        }
        
        let array: [String] = [newText, cipher]
        
        return array
    }
    
    static func encrypt(_ text: String, _ cipher: String) -> String
    {
        var textRepeat = text
        var newText = ""
        
        var cipherText = cipher
        var cipherArray: [String] = []
        
        for _ in 0..<cipher.count
        {
            let index = cipherText.index(cipherText.startIndex, offsetBy: 1)
            let substring = String(cipherText.prefix(upTo: index))
            cipherArray.append(substring)
            
            cipherText = String(cipherText.suffix(from: index))
        }
        
        var cipher = ""
        for i in 0..<cipherArray.count
        {
            cipher += cipherArray[i]
        }
        
        var location = letterArray.firstIndex(of: "A")
        
        for _ in 0..<text.count
        {
            let index = textRepeat.index(textRepeat.startIndex, offsetBy: 1)
            let substring = String(textRepeat.prefix(upTo: index))
            location = letterArray.firstIndex(of: substring.uppercased())
            
            textRepeat = String(textRepeat.suffix(from: index))
            
            if location == nil && substring != " "
            {
                let array = "ERROR 003 - INVALID CHARACTER"
                
                return array
            }
            else if substring == " "
            {
                newText += " "
            }
            else
            {
                if substring.uppercased() == substring
                {
                    newText += cipherArray[location!]
                }
                else
                {
                    newText += cipherArray[location!].lowercased()
                }
            }
        }
        
        let array = newText
        
        return array
    }
}
