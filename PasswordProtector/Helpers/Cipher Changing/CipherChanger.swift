//
//  CipherChanger.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/27/21.
//

import Foundation
import UIKit

class CipherChanger
{
    private static var letterArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    private static func convertToArray(_ cipher: String) -> [String]
    {
        var cipherText = cipher
        var cipherArray: [String] = []
        
        for _ in 0..<cipher.count
        {
            let index = cipherText.index(cipherText.startIndex, offsetBy: 1)
            let substring = String(cipherText.prefix(upTo: index))
            cipherArray.append(substring)
            
            cipherText = String(cipherText.suffix(from: index))
        }
        
        return cipherArray
    }
    
    static func containsAllOfTheOther(_ cipher: String) -> Bool
    {
        let cipherArray: [String] = convertToArray(cipher)
        let letterSet = Set(letterArray)
        let cipherSet = Set(cipherArray)
        
        return cipherSet.isSubset(of: letterSet)
    }
}
