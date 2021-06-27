//
//  TabbedPane.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 6/24/21.
//

import Foundation
import UIKit

class TabbedPane
{
    static func stylePane(tabbedView: UIView!)
    {
        tabbedView.layer.cornerRadius = tabbedView.frame.height/2
        tabbedView.clipsToBounds = true
    }
}
