//
//  SwipeController.swift
//  PasswordProtector
//
//  Created by Rishi Wadhwa on 7/19/21.
//

import Foundation
import UIKit
import WebKit

class SwipeController: UIViewController
{
    @IBOutlet weak var tos: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleUpSwipe(gesture:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        
        tos.layer.cornerRadius = 25
    }
    
    @objc func handleUpSwipe(gesture: UIGestureRecognizer)
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer
        {
            switch (swipeGesture.direction)
            {
            case .up:
                self.performSegue(withIdentifier: "SwipeSegue", sender: (gesture as Any))
                break
            default:
                print("Illegal Swipe")
                break
            }
        }
    }
}
