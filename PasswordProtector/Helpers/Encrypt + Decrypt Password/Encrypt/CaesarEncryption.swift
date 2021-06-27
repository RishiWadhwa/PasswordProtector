//
//  CaesarEncryption.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/25/21.
//

import Foundation
import UIKit

class CaesarEncryption
{
    private static var letterArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    private static func generateCipher() -> [String]
    {
        var cipherArray = letterArray
        
        var index = 0
        
        for i in 0..<letterArray.count
        {
            index = i-3
            
            if index < 0
            {
                index += 26
            }
            
            cipherArray[index] = letterArray[i]
        }
        
        return cipherArray
    }
    
    static func generateEncryption(_ text: String) -> String
    {
        var newText = ""
        var textRepeat = text
        let cipherArray = generateCipher()
        
        for _ in 0..<text.count
        {
            let index = textRepeat.index(textRepeat.startIndex, offsetBy: 1)
            let substring = String(textRepeat.prefix(upTo: index))
            let location = cipherArray.firstIndex(of: substring.uppercased())
            
            textRepeat = String(textRepeat.suffix(from: index))
            
            if location == nil && substring != " "
            {
                return "ERROR INVALID CHARACTER"
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
