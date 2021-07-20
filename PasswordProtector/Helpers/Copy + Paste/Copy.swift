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
    static func copyText(_ str: String)
    {
        UIPasteboard.general.string = str
        print(UIPasteboard.general.string ?? "NOTHING COPIED")
    }
}
