//
//  GeneratePassword.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/24/21.
//

import Foundation

class GeneratePassword
{
    private static var characterArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    private static var numberArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    private static var specialArray = ["!", "@", "#", "$", "%", "&", "*"]
    
    static func MakePassword(_ len: Int) -> String
    {
        var password = ""
        
        for _ in 1...len
        {
            password += randomAlphabet()
        }
        
        return password
    }
    
    static func MakeSpecialPassword(_ len: Int) -> String
    {
        var password = ""
        
        for _ in 1...len
        {
            password += randomCharacter()
        }
        
        return password
    }
    
    private static func randomAlphabet() -> String
    {
        var index = Int.random(in: 0..<(characterArray.count*2))
        if index < characterArray.count
        {
            return characterArray[index]
        }
        else
        {
            index -= characterArray.count
            return characterArray[index].lowercased()
        }
    }
    
    private static func randomCharacter() -> String
    {
        let characterCount = characterArray.count*2
        let numberCount = numberArray.count
        let specialCount = specialArray.count
        let totalCount = characterCount + numberCount + specialCount
        
        var index = Int.random(in: 0..<totalCount)
        if index < characterCount
        {
            if index < characterArray.count
            {
                return characterArray[index]
            }
            else
            {
                index -= characterArray.count
                return characterArray[index].lowercased()
            }
        }
        else if index < (numberCount + characterCount)
        {
            return numberArray[index - characterCount]
        }
        else
        {
            return specialArray[index - characterCount - numberCount]
        }
    }
}
