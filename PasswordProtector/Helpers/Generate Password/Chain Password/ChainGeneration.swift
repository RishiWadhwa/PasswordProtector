//
//  ChainGeneratiojn.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 11/9/21.
//

import Foundation

class ChainGeneration
{
    private static var chainLen = 4
    private static var charChain = 5
    private static var chain = ""
    
    private static var characterArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    private static var numberArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    
    static func generatePasswordChain(_ length: Int, _ characters: Int, _ includeNum: Bool) -> String
    {
        
        chainLen = length
        charChain = characters
        
        var chains: [String] = []
        for _ in 1...chainLen
        {
            if includeNum
            {
                chains.append(generateAllChain())
            }
            else
            {
                chains.append(generateLetterChain())
            }
        }
        
        var chainPassword = ""
        for i in 0..<chains.count {
            chainPassword += chains[i]
            if i != chains.count-1
            {
                chainPassword += "-"
            }
        }
        
        return chainPassword
    }
    
    private static func generateLetterChain() -> String
    {
        var chain = ""
        
        for _ in 1...charChain {
            chain += randomLetter()
        }
        
        return chain
    }
    
    private static func generateAllChain() -> String
    {
        var chain = ""
        
        for _ in 1...charChain {
            chain += randomCharacter()
        }
        
        return chain
    }
    
    private static func randomLetter() -> String
    {
        var index = Int.random(in: 0..<(characterArray.count*3))
        if index < characterArray.count
        {
            return characterArray[index]
        }
        else
        {
            index -= characterArray.count*2
            return characterArray[index].lowercased()
        }
    }
    
    private static func randomCharacter() -> String
    {
        let characterCount = characterArray.count
        let numberCount = numberArray.count
        let totalCount = characterCount + numberCount + numberCount
        
        let index = Int.random(in: 0..<totalCount)
        if index < characterCount
        {
            let upperOrLower = Int.random(in: 0..<11)
            if upperOrLower < 6 // uppercase
            {
                return characterArray[upperOrLower].uppercased()
            }
            else // lowercase
            {
                return characterArray[upperOrLower].lowercased()
            }
        }
        else if index < characterCount + numberCount
        {
            return numberArray[index - characterCount]
        }
        else
        {
            return numberArray[index - characterCount - numberCount]
        }
    }
    
}
