//
//  Copy.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/27/21.
//

import Foundation
import UIKit

class Copy
{
    static func copyText(_ str: String) -> UIColor
    {
        UIPasteboard.general.string = str
        print(UIPasteboard.general.string ?? "")
        if UIPasteboard.general.string != nil || UIPasteboard.general.string == ""
        {
            return UIColor.green
        }
        
        return UIColor.red
    }
}
